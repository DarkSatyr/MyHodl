//
//  MainTabView.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label(L10n.dashboard, systemImage: "chart.line.uptrend.xyaxis")
                }
            
            HoldingsView()
                .tabItem {
                    Label(L10n.holdings, systemImage: "bitcoinsign.circle")
                }
            
            SettingsView()
                .tabItem {
                    Label(L10n.settings, systemImage: "gearshape")
                }
        }
        .tint(themeManager.currentTheme.accent)
    }
}

#Preview {
    MainTabView()
        .environment(ThemeManager())
}
