//
//  MainTabView.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(ThemeManager.self) private var themeManager
    @Environment(AppContainer.self) private var appContainer
    
    var body: some View {
        TabView {
            DashboardView(viewModel: appContainer.makeDashboardViewModel())
                .tabItem {
                    Label(L10n.dashboard, systemImage: "chart.line.uptrend.xyaxis")
                }
            
            HoldingsView(viewModel: appContainer.makeHoldingsViewModel())
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
