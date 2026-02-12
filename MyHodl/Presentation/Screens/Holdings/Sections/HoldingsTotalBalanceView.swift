//
//  HoldingsTotalBalanceView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.02.2026.
//

import SwiftUI

struct AssetsCount {
    let total: Int
    let filtered: Int
    var isFiltered: Bool {
        total > filtered
    }
}

struct HoldingsTotalBalanceView: View {
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var dayChangeTracker = DayChangeTracker()
    var total: Decimal?
    var assetsCount: AssetsCount?
    
    var body: some View {
        ZStack {
            DashboardCard()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(L10n.totalBalance)
                        .font(themeManager.currentTheme.sectionHeaderFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    Spacer()
                    Text(FiatSymbol.symbol(for: baseCurrency) + AmountFormat.amount(total, currency: baseCurrency))
                        .font(themeManager.currentTheme.sectionHeaderFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                }
                // TODO: Add pluralisms
                if let assetsCount {
                    let text = assetsCount.isFiltered
                        ? "\(assetsCount.filtered) result (of \(assetsCount.total) assets)"
                        : "\(assetsCount.total) assets"

                    Text(text)
                        .font(themeManager.currentTheme.font)
                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                }
            }
            .padding(.all)
        }
        .onAppear {
            dayChangeTracker.start()
        }
    }
}

#Preview {
    HoldingsTotalBalanceView()
        .environment(ThemeManager())
        .frame(maxHeight: 100)
}
