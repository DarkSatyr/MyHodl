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

    var body: some View {
        MyHodlView()
            .background(themeManager.currentTheme.background)
            .onAppear {
                themeManager.updateSystemScheme(systemScheme)
            }
            .onChange(of: systemScheme) { _, new in
                themeManager.updateSystemScheme(new)
            }
    }
}
