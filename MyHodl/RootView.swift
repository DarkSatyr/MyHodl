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
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem {
                        Button {
                            showSettings = true
                        } label: {
                            Image(.settings)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                        .preferredColorScheme(
                            themeManager.preferredSystemScheme() ?? ThemeManager.systemScheme()
                        )
                }
        }
        .background(themeManager.currentTheme.background)
        .onAppear {
            themeManager.updateSystemScheme(systemScheme)
        }
        .onChange(of: systemScheme) { _, new in
            themeManager.updateSystemScheme(new)
        }
    }
}
