//
//  MainTabView.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

enum MainTab {
    case dashboard
    case holdings
    case settings
}

struct MainTabView: View {
    @State var selectedTab = MainTab.dashboard
    @Environment(ThemeManager.self) private var themeManager
    @Environment(AppContainer.self) private var appContainer
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(viewModel: appContainer.makeDashboardViewModel()) {
                selectedTab = .holdings
            }
            .tabItem {
                Label(L10n.dashboard, systemImage: "chart.line.uptrend.xyaxis")
            }
            .tag(MainTab.dashboard)
            
            HoldingsView(viewModel: appContainer.makeHoldingsViewModel())
                .tabItem {
                    Label(L10n.holdings, systemImage: "bitcoinsign.circle")
                }
                .tag(MainTab.holdings)
            
            SettingsView()
                .tabItem {
                    Label(L10n.settings, systemImage: "gearshape")
                }
                .tag(MainTab.settings)
        }
        .tint(themeManager.currentTheme.accent)
    }
}

#Preview {
    MainTabView()
        .environment(ThemeManager())
}
