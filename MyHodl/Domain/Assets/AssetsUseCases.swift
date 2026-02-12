//
//  AssetsUseCases.swift
//  MyHodl
//
//  Created by DarkSatyr on 06.02.2026.
//

import Foundation
import Combine

enum AssetsUseCases {
    
    struct GetAssetByCode {
        let repo: AssetsRepository
        func callAsFunction(_ code: String) throws -> Asset? {
            try repo.asset(code: code)
        }
    }
    
    struct UpsertAsset {
        
        enum UpsertResult {
            case inserted
            case merged
        }
        
        let repo: AssetsRepository
        
        @discardableResult
        func callAsFunction(_ incoming: Asset) throws -> UpsertResult {
            if let existing = try repo.asset(code: incoming.code) {
                let newAmount = existing.amount + incoming.amount
                let newAvg = mergedAvgCost(
                    oldAvg: existing.startingPrice,
                    oldAmount: existing.amount,
                    addPrice: incoming.startingPrice,   // buy price per coin
                    addAmount: incoming.amount
                )
                try repo.save(existing.copy(amount: newAmount, startingPrice: newAvg))
                return .merged
            } else {
                try repo.save(incoming)
                return .inserted
            }
        }
        
        private func mergedAvgCost(
            oldAvg: Decimal?,
            oldAmount: Decimal,
            addPrice: Decimal?,
            addAmount: Decimal
        ) -> Decimal? {
            guard addAmount > 0 else { return oldAvg }

            switch (oldAvg, addPrice) {
            case let (oldAvg?, addPrice?):
                let total = oldAmount + addAmount
                guard total > 0 else { return nil }
                return (oldAmount * oldAvg + addAmount * addPrice) / total

            case (nil, let addPrice?):
                return addPrice

            case (_, nil):
                return oldAvg
            }
        }
    }

    struct Observe {
        let repo: AssetsRepository
        func callAsFunction() -> AnyPublisher<[Asset], Never> {
            repo.observeAssets()
        }
    }
    
    struct Delete {
        let repo: AssetsRepository
        func callAsFunction(_ ids: Set<String>) throws {
            try repo.delete(ids)
        }
    }
}
