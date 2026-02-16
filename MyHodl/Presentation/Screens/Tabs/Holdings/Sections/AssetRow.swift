//
//  AssetRow.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import SwiftUI

struct AssetRow: View {
    
    let asset: DashboardAsset
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                IconView(source: asset.icon)
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 2) {
                    Text(asset.fullName.capitalized)
                        .font(themeManager.currentTheme.sectionTextFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    HStack(spacing: 2) {
                        Text(AmountFormat.amount(asset.amount, currency: asset.code))
                            .font(themeManager.currentTheme.font)
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                        Text(asset.code.uppercased())
                            .font(themeManager.currentTheme.font)
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                    }
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(optional: AmountFormat.fiatAmountPrefixed(asset.totalCurrent, currency: baseCurrency))
                    .font(themeManager.currentTheme.sectionTextFont)
                    .foregroundStyle(themeManager.currentTheme.text)
//                        if asset.code.uppercased() != baseCurrency {
//                            Text(AmountFormat.percentChange(asset.changePercent))
//                                .font(themeManager.currentTheme.font)
//                                .foregroundStyle(themeManager.currentTheme.color(change: asset.changePercent))
//                        } else {
//                        }
            }
        }
        .contentShape(Rectangle())
    }
}
