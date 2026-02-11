//
//  BalanceView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct BalanceView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var dayChangeTracker = DayChangeTracker()
    var total: Decimal?
    var changePercent: Decimal?
    let showDate: Bool
    
    init(total: Decimal?, changePercent: Decimal?, showDate: Bool = false) {
        self.total = total
        self.changePercent = changePercent
        self.showDate = showDate
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
                if showDate {
                    Text(dayChangeTracker.currentDay.formatted(date: .abbreviated,
                                                               time: .omitted))
                    .font(themeManager.currentTheme.sectionHeaderFont)
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
    BalanceView(total: 1233.34, changePercent: 2.3)
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
