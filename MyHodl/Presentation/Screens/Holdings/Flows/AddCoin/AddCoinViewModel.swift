//
//  AddCoinViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 26.11.2025.
//

import Foundation
import Combine

@MainActor
final class AddCoinViewModel: ObservableObject {
    
    enum Route: Hashable {
        case assetSelected(AssetID?)
    }
    
    struct SearchResult {
        let assets: [CryptoAssetInfo]
        let sectionName: String
    }
    
    @Published var searchedText = ""
    @Published var searchResult = SearchResult(assets: [], sectionName: "Popular assets") // TODO: Add loc
    @Published var path = [Route]()
    private let fetchAssetsUseCase: FetchCryptoAssetsInfoUseCase
    
    init(fetchAssetsUseCase: FetchCryptoAssetsInfoUseCase) {
        self.fetchAssetsUseCase = fetchAssetsUseCase
        $searchedText
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .prepend("")
            .flatMapAsync { [weak self] text in
                guard let self else { return SearchResult(assets: [], sectionName: "Popular assets") }
                if text.isEmpty {
                    return SearchResult(assets: await fetchAssetsUseCase.topAssets(),
                                        sectionName: "Popular assets")  // TODO: Add loc
                }
                let assets = await self.fetchAssetsUseCase.assets(for: .search(text: text))
                return SearchResult(assets: assets, sectionName: "Search result")  // TODO: Add loc
            }
            .receive(on: RunLoop.main)
            .assign(to: &$searchResult)
    }
    
    func showAddCoin(asset: AssetID?) {
        path.append(.assetSelected(asset))
    }
}
