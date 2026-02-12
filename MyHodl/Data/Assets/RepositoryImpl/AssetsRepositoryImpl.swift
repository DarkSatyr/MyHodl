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
    private let changes = PassthroughSubject<Void, Never>()
    
    private lazy var assetsPublisher: AnyPublisher<[Asset], Never> = {
        let queue = DispatchQueue(label: "assets.observe.queue")

        let fetch: () throws -> [Asset] = { [modelContainer] in
            let context = ModelContext(modelContainer)
            let descriptor = FetchDescriptor<AssetRecord>()
            let records = try context.fetch(descriptor)
            return records.map { $0.toDomain() }
        }
        let didSave = NotificationCenter.default.publisher(for: ModelContext.didSave, object: nil)
            .map { _ in () }
        let trigger = Publishers.Merge(didSave, changes)
            .prepend(())

        return trigger
            .receive(on: queue)
            .tryMap { _ in try fetch() }
            .replaceError(with: [])
            .multicast(subject: CurrentValueSubject<[Asset], Never>([]))
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }()
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func save(_ asset: Asset) throws {
        let context = ModelContext(modelContainer)
        if let record = try self.fetchAssetRecord(code: asset.code, context: context) {
            // update
            record.fullName = asset.fullName
            record.amount = asset.amount
            record.startingPrice = asset.startingPrice
            record.currentPrice = asset.currentPrice
        } else {
            // insert
            context.insert(AssetRecord(from: asset))
        }
        try context.save()
    }
    
    func observeAssets() -> AnyPublisher<[Asset], Never> {
        assetsPublisher
    }
    
    func asset(code: String) throws -> Asset? {
        let record = try fetchAssetRecord(code: code, context: ModelContext(modelContainer))
        return record?.toDomain()
    }
    
    func delete(_ ids: Set<String>) throws {
        guard !ids.isEmpty else { return }
        let normalizedIds = ids.map { $0.normalize() }
        let context = ModelContext(modelContainer)
        try context.delete(model: AssetRecord.self, where: #Predicate {
            normalizedIds.contains($0.id)
        })
        try context.save()
        changes.send(())
    }
    
    private func fetchAssetRecord(code: String, context: ModelContext) throws -> AssetRecord? {
        let normalized = code.normalize()
        var descriptor = FetchDescriptor<AssetRecord>(predicate: #Predicate {
            $0.code == normalized
        })
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
}
