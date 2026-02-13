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
    @Published var isEmpty = false
    private let assetsObserveUseCase: AssetsUseCases.Observe
    private var cancellables = Set<AnyCancellable>()
    
    init(assetsObserveUseCase: AssetsUseCases.Observe) {
        self.assetsObserveUseCase = assetsObserveUseCase
        assetsObserveUseCase()
            .map { $0.map(DashboardAsset.init) }
            .assign(to: &$assets)
        
        $assets
            .dropFirst()
            .sink(receiveValue: { [weak self] assets in
                guard let self else { return }
                let totalCurrent = Self.totalCurrent(for: assets)
                totalBalance = totalCurrent
                let totalEntry = Self.totalEntry(for: assets)
                totalBalanceChange = Self.totalBalanceChangePercent(current: totalCurrent, entry: totalEntry)
                let totalCurrentFiat = Self.totalFiatAllocation(for: assets)
                assetAllocation = AssetAllocation(fiat: totalCurrentFiat / totalCurrent)
                isEmpty = assets.isEmpty
            })
            .store(in: &cancellables)
    }

    private static func totalBalanceChangePercent(current: Decimal, entry: Decimal) -> Decimal? {
        guard entry > 0 else { return nil }
        return (current - entry) / entry
    }
    
    private static func totalCurrent(for assets: [DashboardAsset]) -> Decimal {
        assets
            .reduce(0, { result, asset in
                result + (asset.totalCurrent ?? 0)
            })
    }
    
    private static func totalEntry(for assets: [DashboardAsset]) -> Decimal {
        assets
            .reduce(0, { result, asset in
                result + (asset.totalEntry ?? 0)
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
