//
//  BundleCryptoAssetsInfoRepository.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

final class BundleCryptoAssetsInfoRepository: CryptoAssetsInfoRepository {

    private let loader: CryptoAssetsFileLoader
    private let cachedAssets: [CryptoAssetInfo]

    init(loader: CryptoAssetsFileLoader = CryptoAssetsFileLoader()) {
        self.loader = loader
        
        do {
            self.cachedAssets = try loader.loadAssetsList()
                .sorted { $0.sortRank < $1.sortRank }
        } catch {
            assertionFailure("Failed to load crypto_coins_list.json: \(error)")
            self.cachedAssets = []
        }
    }

    // MARK: - CryptoAssetsInfoRepository

    func getAllAssets() async -> [CryptoAssetInfo] {
        cachedAssets
    }

    func getAsset(id: String) async throws -> CryptoAssetInfo? {
        cachedAssets.first { $0.id == id }
    }

    func searchAssets(text: String) async -> [CryptoAssetInfo] {
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

    func topAssets(count: Int) async -> [CryptoAssetInfo] {
        Array(cachedAssets.prefix(count))
    }
}
