//
//  AssetsUseCases.swift
//  MyHodl
//
//  Created by DarkSatyr on 06.02.2026.
//

import Foundation
import Combine

enum AssetsUseCases {
    
    struct Add {
        let repo: AssetsRepository
        func callAsFunction(asset: Asset) throws {
            try repo.save(asset)
        }
    }

    struct Observe {
        let repo: AssetsRepository
        func callAsFunction() -> AnyPublisher<[Asset], Never> {
            repo.observeAssets()
        }
    }
}
