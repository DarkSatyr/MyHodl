//
//  FetchCryptoAssetsInfoUseCase.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

struct FetchCryptoAssetsInfoUseCase {

    public enum Mode {
        case all
        case search(text: String)
    }
    
    private let repository: CryptoAssetsInfoRepository
    
    init(repository: CryptoAssetsInfoRepository) {
        self.repository = repository
    }
    
    func assets(for mode: Mode) async -> [CryptoAssetInfo] {
        switch mode {
        case .all:
            await repository.getAllAssets()
        case .search(let text):
            await repository.searchAssets(text: text)
        }
    }
    
    func topAssets(count: Int = 6) async -> [CryptoAssetInfo] {
        await repository.topAssets(count: count)
    }
}
