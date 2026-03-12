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
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            DashboardView(viewModel: appContainer.makeDashboardViewModel(),
                          router: router.dashboardRouter,
                          onShowHoldings: {
                router.selectedTab = .holdings
            })
            .tabItem {
                Label(L10n.dashboard, systemImage: "chart.line.uptrend.xyaxis")
            }
            .tag(AppRouter.Tab.dashboard)
            
            HoldingsView(viewModel: appContainer.makeHoldingsViewModel(), router: router.holdingsRouter)
                .tabItem {
                    Label(L10n.holdings, systemImage: "bitcoinsign.circle")
                }
                .tag(AppRouter.Tab.holdings)
            
            SettingsView(router: router.settingsRouter)
                .tabItem {
                    Label(L10n.settings, systemImage: "gearshape")
                }
                .tag(AppRouter.Tab.settings)
        }
        .tint(themeManager.currentTheme.accent)
    }
}

#Preview {
    MainTabView()
        .environment(ThemeManager())
}
