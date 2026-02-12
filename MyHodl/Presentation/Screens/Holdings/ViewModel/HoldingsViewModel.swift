//
//  HoldingsViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import SwiftUI
import Combine

@MainActor
final class HoldingsViewModel: ObservableObject {
    
    @Published var assets = [DashboardAsset]()
    @Published var filteredAssets = [DashboardAsset]()
    @Published var assetsCount: AssetsCount?
    @Published var totalBalance: Decimal?
    @Published var totalBalanceChange: Decimal?
    @Published var searchText = ""
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
                isEmpty = assets.isEmpty
            })
            .store(in: &cancellables)
        
        Publishers.CombineLatest($assets, $searchText)
            .debounce(for: .milliseconds(50), scheduler: RunLoop.main)
            .map { assets, searchText in
                Self.filterAssets(assets, searchText: searchText)
            }
            .assign(to: &$filteredAssets)
        
        Publishers.CombineLatest($assets, $filteredAssets)
            .map { (all, filtered) in
                AssetsCount(total: all.count, filtered: filtered.count)
            }
            .assign(to: &$assetsCount)
    }
    
    private static func filterAssets(_ assets: [DashboardAsset], searchText: String) -> [DashboardAsset] {
        guard !searchText.isEmpty else { return assets }
        return assets
            .filter { asset in
                asset.code.localizedCaseInsensitiveContains(searchText) ||
                asset.fullName.localizedCaseInsensitiveContains(searchText)
            }
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
}

