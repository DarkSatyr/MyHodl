//
//  DashboardAsset.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import Foundation

struct DashboardAsset: Identifiable {
    let code: String
    let fullName: String
    let icon: ImageSource
    let currentPrice: Decimal?
    let previousPrice: Decimal?
    let amount: Decimal
    var id: String { code }
    
    var changePercent: Decimal? {
        guard let currentPrice, let previousPrice, previousPrice != 0 else { return nil }
        return (currentPrice - previousPrice) / previousPrice
    }
    
    var totalEntry: Decimal? {
        guard let previousPrice else { return nil }
        return previousPrice * amount
    }
    
    var totalCurrent: Decimal? {
        guard let currentPrice else { return nil }
        return currentPrice * amount
    }
}

extension DashboardAsset {
    init(_ asset: Asset) {
        self.init(
            code: asset.code,
            fullName: asset.fullName,
            icon: .local(name: asset.code),
            currentPrice: asset.currentPrice,
            previousPrice: asset.startingPrice,
            amount: asset.amount
        )
    }
}
