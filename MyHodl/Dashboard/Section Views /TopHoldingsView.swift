//
//  TopHoldingsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct TopHoldingsView: View {
    var assets: [DashboardAsset]
    @Environment(ThemeManager.self) private var themeManager
    
    init(assets: [DashboardAsset]) {
        self.assets = Array(assets.sorted(by: { lhs, rhs in
            lhs.totalCurrent > rhs.totalCurrent
        })
        .prefix(6))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.topHoldings)
                .font(themeManager.currentTheme.sectionHeaderFont)
                .foregroundStyle(themeManager.currentTheme.textSecondary)
            LazyVStack(spacing: 12) {
                ForEach(assets) { asset in
                    HStack {
                        HStack(spacing: 10) {
                            IconView(source: asset.icon)
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(asset.fullName.capitalized)
                                    .font(themeManager.currentTheme.sectionTextFont)
                                    .foregroundStyle(themeManager.currentTheme.text)
                                Text(asset.code.uppercased())
                                    .font(themeManager.currentTheme.font)
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text(AmountFormat.amount(asset.totalCurrent, currency: baseCurrency))
                                .font(themeManager.currentTheme.sectionTextFont)
                                .foregroundStyle(themeManager.currentTheme.text)
                            if asset.code.uppercased() != baseCurrency {
                                Text(AmountFormat.percentChange(asset.changePercent))
                                    .font(themeManager.currentTheme.font)
                                    .foregroundStyle(themeManager.currentTheme.color(change: asset.changePercent))
                            } else {
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    TopHoldingsView(assets: [DashboardAsset(code: "BTC", fullName: "Bitcoin", icon: .bundle(name: "btc"), currentPrice: 100000, previousPrice: 90001, amount: 1.2)])
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
