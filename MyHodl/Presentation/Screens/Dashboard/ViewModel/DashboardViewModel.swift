//
//  DashboardViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {
    
    @Published var assets = [DashboardAsset]()
    @Published var totalBalance: Decimal?
    @Published var totalBalanceChange: Decimal?
    @Published var assetAllocation: AssetAllocation?
    
    private let assetsStubs = StubDataModel().assets
    
    init() {
        assets = assetsStubs
            .map { asset in
                DashboardAsset(code: asset.code,
                               fullName: asset.fullName,
                               icon: ImageSource.local(name: asset.icon),
                               currentPrice: asset.currentPrice,
                               previousPrice: asset.startingPrice,
                               amount: asset.amount)
            }
        let totalCurrent = Self.totalCurrent(for: assets)
        totalBalance = totalCurrent
        let totalEntry = Self.totalEntry(for: assets)
        totalBalanceChange = Self.totalBalanceChangePercent(current: totalCurrent, entry: totalEntry)
        let totalCurrentFiat = Self.totalFiatAllocation(for: assets)
        assetAllocation = AssetAllocation(fiat: totalCurrentFiat / totalCurrent)
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
    
    private static func totalFiatAllocation(for assets: [DashboardAsset]) -> Decimal {
        let fiatAssets = assets
            .filter { asset in
                FiatSymbol.isFiatSymbol(asset.code)
            }
        return totalCurrent(for: fiatAssets)
    }
}
