//
//  DashboardViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI
import Combine

struct DashboardAsset: Identifiable {
    let code: String
    let fullName: String
    let icon: ImageSource
    let currentPrice: Decimal
    let previousPrice: Decimal
    let amount: Decimal
    var id: String { code }
    
    var changePercent: Decimal? {
        guard previousPrice != 0 else { return nil }
        return (currentPrice - previousPrice) / previousPrice
    }
    
    var totalEntry: Decimal {
        previousPrice * amount
    }
    
    var totalCurrent: Decimal {
        currentPrice * amount
    }
}

final class DashboardViewModel: ObservableObject {
    
    struct SubTotal {
        let total: Decimal
        let currency: String
    }
    
    @Published var assets = [DashboardAsset]()
    @Published var totalBalance: Decimal?
    @Published var totalBalanceChange: Decimal?
    
    private let assetsStubs = StubDataModel().assets
    
    init() {
        assets = assetsStubs
            .map { asset in
                let image = asset.icon != nil ? ImageSource.bundle(name: asset.icon!) : ImageSource.placeholder
                return DashboardAsset(code: asset.code,
                                      fullName: asset.fullName,
                                      icon: image,
                                      currentPrice: asset.currentPrice,
                                      previousPrice: asset.startingPrice,
                                      amount: asset.amount)
            }
        let totalCurrent = Self.totalCurrent(for: assets)
        totalBalance = totalCurrent
        let totalEntry = Self.totalEntry(for: assets)
        totalBalanceChange = Self.totalBalanceChangePercent(current: totalCurrent, entry: totalEntry)
    }
    
    private static func totalBalanceChangePercent(current: Decimal, entry: Decimal) -> Decimal? {
        guard entry > 0 else { return nil }
        return (current - entry) / entry
    }
    
    private static func totalCurrent(for assets: [DashboardAsset]) -> Decimal {
        assets
            .reduce(0, { result, asset in
                result + asset.totalCurrent
            })
    }
    
    private static func totalEntry(for assets: [DashboardAsset]) -> Decimal {
        assets
            .reduce(0, { result, asset in
                result + asset.totalEntry
            })
    }
}
