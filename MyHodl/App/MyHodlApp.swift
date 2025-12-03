//
//  MyHodlApp.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

@main
struct MyHodlApp: App {
    @State private var themeManager: ThemeManager
    @State private var appContainer: AppContainer
    
    init() {
        let appContainer = AppContainer()
        _appContainer = State(wrappedValue: appContainer)
        _themeManager = State(wrappedValue: appContainer.makeThemeManager())
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appContainer)
                .environment(themeManager)
                .foregroundStyle(themeManager.currentTheme.background)
                .preferredColorScheme(themeManager.preferredSystemScheme())
        }
    }
}
