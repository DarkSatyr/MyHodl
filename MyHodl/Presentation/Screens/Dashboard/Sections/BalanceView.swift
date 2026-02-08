//
//  BalanceView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct BalanceView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    var total: Decimal?
    var changePercent: Decimal?
    
    init(total: Decimal?, changePercent: Decimal?) {
        self.total = total
        self.changePercent = changePercent
    }
    
    var body: some View {
        ZStack {
            DashboardCard()
            VStack(alignment: .leading, spacing: 8) {
                Text(L10n.totalBalance)
                    .font(themeManager.currentTheme.sectionHeaderFont)
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                HStack {
                    Text(FiatSymbol.symbol(for: baseCurrency) + AmountFormat.amount(total, currency: baseCurrency))
                        .font(themeManager.currentTheme.headerFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    Spacer()
//                    Text(AmountFormat.percentChange(changePercent))
//                        .font(themeManager.currentTheme.sectionTextFont)
//                        .foregroundStyle(themeManager.currentTheme.color(change: changePercent))
                }
            }
            .padding(.all)
        }
    }
}

#Preview {
    BalanceView(total: 1233.34, changePercent: 2.3)
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
