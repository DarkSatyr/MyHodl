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
                            Text(asset.currentPrice)
                                .font(themeManager.currentTheme.sectionTextFont)
                                .foregroundStyle(themeManager.currentTheme.text)
                            Text(asset.percentChange)
                                .font(themeManager.currentTheme.font)
                                .foregroundStyle(themeManager.currentTheme.accent)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    TopHoldingsView(assets: [DashboardAsset(code: "BTC", fullName: "Bitcoin", icon: .bundle(name: "btc"), currentPrice: "100000", percentChange: "-2.1%")])
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
