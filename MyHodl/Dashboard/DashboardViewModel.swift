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
    let percentChange: String
    var id: String { code }
}

final class DashboardViewModel: ObservableObject {
    
    @Published var assets = [DashboardAsset]()
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
                                      percentChange: change ?? "-")
            }
    }
}
