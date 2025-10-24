//
//  MyHodlApp.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

@main
struct MyHodlApp: App {
    @State private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(themeManager)
                .preferredColorScheme(themeManager.preferredSystemScheme())
        }
    }
}
