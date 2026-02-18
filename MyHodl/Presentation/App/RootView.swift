//
//  RootView.swift
//  MyHodl
//
//  Created by DarkSatyr on 24.10.2025.
//

import SwiftUI

struct RootView: View {
    @Environment(\.colorScheme) private var systemScheme
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var appRouter = AppRouter()

    var body: some View {
        MainTabView()
            .environmentObject(appRouter)
            .background(themeManager.currentTheme.background)
            .onAppear {
                themeManager.updateSystemScheme(systemScheme)
            }
            .onChange(of: systemScheme) { _, new in
                themeManager.updateSystemScheme(new)
            }
    }
}
