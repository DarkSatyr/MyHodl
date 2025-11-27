//
//  BundleAssetRepository.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

final class BundleAssetRepository: AssetRepository {

    private let loader: AssetFileLoader

    private lazy var cachedAssets: [Asset] = {
        do {
            return try loader.loadAssetsList()
        } catch {
            assertionFailure("Failed to load coins_list.json: \(error)")
            return []
        }
    }()

    init(loader: AssetFileLoader = AssetFileLoader()) {
        self.loader = loader
    }

    // MARK: - AssetRepository

    func getAllAssets() async -> [Asset] {
        cachedAssets
    }

    func getAsset(id: String) async throws -> Asset? {
        cachedAssets.first { $0.id == id }
    }

    func searchAssets(text: String) async -> [Asset] {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard query.isEmpty == false else {
            return cachedAssets
        }

        let lowercased = query.lowercased()

        return cachedAssets.filter { asset in
            asset.name.lowercased().contains(lowercased)
            || asset.code.lowercased().contains(lowercased)
            || asset.coingeckoId?.lowercased().contains(lowercased) == true
        }
    }
}
