//
//  FetchAssetsUseCase.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

struct FetchAssetsUseCase {

    public enum Mode {
        case all
        case search(text: String)
    }
    
    private let repository: AssetRepository
    
    init(repository: AssetRepository) {
        self.repository = repository
    }
    
    func assets(for mode: Mode) async -> [Asset] {
        switch mode {
        case .all:
            await repository.getAllAssets()
        case .search(let text):
            await repository.searchAssets(text: text)
        }
    }
    
    func topAssets(count: Int = 6) async -> [Asset] {
        await repository.topAssets(count: count)
    }
}
