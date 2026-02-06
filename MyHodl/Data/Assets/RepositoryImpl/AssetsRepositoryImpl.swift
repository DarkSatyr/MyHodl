//
//  AssetsRepositoryImpl.swift
//  MyHodl
//
//  Created by DarkSatyr on 06.02.2026.
//

import Foundation
import SwiftData
import Combine

final class AssetsRepositoryImpl: AssetsRepository {
    
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func save(_ asset: Asset) throws {
        let context = ModelContext(modelContainer)
        context.insert(AssetRecord(from: asset))
        try context.save()
    }
    
    func observeAssets() -> AnyPublisher<[Asset], Never> {
        let queue = DispatchQueue(label: "assets.observe.queue")

        let fetch: () throws -> [Asset] = { [modelContainer] in
            let context = ModelContext(modelContainer)
            let descriptor = FetchDescriptor<AssetRecord>()
            let records = try context.fetch(descriptor)
            return records.map { $0.toDomain() }
        }
        return NotificationCenter.default.publisher(for: ModelContext.didSave, object: nil)
            .map { _ in () }
            .prepend(())
            .receive(on: queue)
            .tryMap { _ in try fetch() }
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
