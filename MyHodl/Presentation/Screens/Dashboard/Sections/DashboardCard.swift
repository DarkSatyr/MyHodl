//
//  DashboardCard.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.11.2025.
//

import SwiftUI

struct DashboardCard: View {
    
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(.ultraThinMaterial)
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.black.opacity(0.45))
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    LinearGradient(colors: [
                        themeManager.currentTheme.accent.opacity(0.06),
                        Color.black.opacity(0.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                )
        }
    }
}

#Preview {
    BalanceView(total: 112.34, changePercent: -1.2)
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}

#Preview {
    DashboardCard()
}
