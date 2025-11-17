//
//  BalanceView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct BalanceView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        ZStack {
            DashboardCard()
            VStack(alignment: .leading, spacing: 8) {
                Text(L10n.totalBalance)
                    .font(themeManager.currentTheme.sectionHeaderFont)
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                HStack {
                    Text("$34944.1")
                        .font(themeManager.currentTheme.headerFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    Spacer()
                    Text("+2.8%")
                        .font(themeManager.currentTheme.sectionTextFont)
                        .foregroundStyle(themeManager.currentTheme.accent)
                }
            }
            .padding(.all)
        }
    }
}

#Preview {
    BalanceView()
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
