//
//  AssetAllocationView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct AssetAllocation {
    let crypto: Decimal
    let fiat: Decimal
}

struct AssetAllocationView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    var assetAllocation: AssetAllocation
    
    var body: some View {
        ZStack(alignment: .leading) {
            DashboardCard()
            VStack(alignment: .leading, spacing: 12) {
                Text(L10n.assetAllocation)
                    .font(themeManager.currentTheme.sectionHeaderFont)
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                VStack(alignment: .leading, spacing: 8) {
                    if assetAllocation.crypto > assetAllocation.fiat {
                        Text(L10n.crypto)
                            .font(themeManager.currentTheme.highlightedFont)
                            .foregroundStyle(themeManager.currentTheme.text)
                        Text(AmountFormat.percent(assetAllocation.crypto))
                            .font(themeManager.currentTheme.highlightedFont)
                            .foregroundStyle(themeManager.currentTheme.accent)
                    } else {
                        Text(L10n.fiat)
                            .font(themeManager.currentTheme.highlightedFont)
                            .foregroundStyle(themeManager.currentTheme.text)
                        Text(AmountFormat.percent(assetAllocation.fiat))
                            .font(themeManager.currentTheme.highlightedFont)
                            .foregroundStyle(themeManager.currentTheme.accent)
                    }
                    
                    HStack {
                        HStack {
                            Text(L10n.crypto)
                                .font(themeManager.currentTheme.font)
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                        }
                        HStack {
                            Text(L10n.fiat)
                                .font(themeManager.currentTheme.font)
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                        }
                    }
                }
            }
            .padding(.all)
        }
    }
}

extension AssetAllocation {
    init?(crypto: Decimal) {
        guard crypto.isValid, crypto >= 0 else {
            return nil
        }
        self.crypto = crypto
        self.fiat = 1 - crypto
    }
    
    init?(fiat: Decimal) {
        guard fiat.isValid, fiat >= 0 else {
            return nil
        }
        self.fiat = fiat
        self.crypto = 1 - fiat
    }
}

#Preview {
    AssetAllocationView(assetAllocation: AssetAllocation(crypto: 0.638, fiat: 1 - 0.638))
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
