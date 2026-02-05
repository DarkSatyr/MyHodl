//
//  BundleAssetRepository.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

final class BundleAssetRepository: AssetRepository {

    private let loader: AssetFileLoader
    private let cachedAssets: [Asset]

    init(loader: AssetFileLoader = AssetFileLoader()) {
        self.loader = loader
        
        do {
            self.cachedAssets = try loader.loadAssetsList()
                .sorted { $0.sortRank < $1.sortRank }
        } catch {
            assertionFailure("Failed to load coins_list.json: \(error)")
            self.cachedAssets = []
        }
    }

    // MARK: - AssetRepository

    func getAllAssets() async -> [Asset] {
        cachedAssets
    }

    func getAsset(id: String) async throws -> Asset? {
        cachedAssets.first { $0.id == id }
    }

    func searchAssets(text: String) async -> [Asset] {
        let query = text.trimmed()
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

    func topAssets(count: Int) async -> [Asset] {
        Array(cachedAssets.prefix(count))
    }
}
