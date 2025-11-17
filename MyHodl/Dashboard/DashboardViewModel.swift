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
    let currentPrice: String
    let previousPrice: String
    let percentChange: String
    let amount: String
    var id: String { code }
}

enum PriceDirection {
    case up
    case down
    case neutral
}

final class DashboardViewModel: ObservableObject {
    
    struct SubTotal {
        let total: Decimal
        let currency: String
    }
    
    @Published var assets = [DashboardAsset]()
    @Published var totalBalance = "-"
    @Published var totalBalanceChange = "-"
    @Published var totalBalanceChangeColor = PriceDirection.neutral
    let currency = "usd"
    
    private let assetsStubs = StubDataModel().assets
    
    init() {
        assets = assetsStubs
            .map { asset in
                let image = asset.icon != nil ? ImageSource.bundle(name: asset.icon!) : ImageSource.placeholder
                let change = PriceFormat.change(start: asset.startingPrice, current: asset.currentPrice)
                return DashboardAsset(code: asset.code,
                                      fullName: asset.fullName,
                                      icon: image,
                                      currentPrice: asset.currentPrice,
                                      previousPrice: asset.startingPrice,
                                      percentChange: change ?? "-",
                                      amount: asset.amount)
            }
        let totalCurrent = Self.total(for: assets, price: \.currentPrice)
        totalBalance = AmountFormat.amount(totalCurrent, currency: currency) ?? "-"
        let totalPrevious = Self.total(for: assets, price: \.previousPrice)
        totalBalanceChange = PriceFormat.change(start: totalPrevious, current: totalCurrent) ?? "-"
        totalBalanceChangeColor = totalCurrent == totalPrevious ? .neutral : (totalCurrent < totalPrevious ? .down : .up)
    }
    
    private static func total(for assets: [DashboardAsset], price: KeyPath<DashboardAsset, String>) -> Decimal {
        assets
            .reduce(Decimal(), { result, asset in
                guard let total = Self.total(by: asset[keyPath: price], amount: asset.amount) else {
                    return result
                }
                return result + total
            })
    }
    
    private static func total(by price: String, amount: String) -> Decimal? {
        guard let amount = Decimal(string: amount),
              let price = Decimal(string: price) else {
            return nil
        }
        return amount * price
    }
}
