//
//  ContentView.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            MyHoldingsView()
                .tabItem {
                    Label("Holdings", systemImage: "bitcoinsign.circle")
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
    ContentView()
        .environment(ThemeManager())
}
