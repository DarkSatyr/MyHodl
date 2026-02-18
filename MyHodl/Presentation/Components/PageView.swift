//
//  PageView.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import SwiftUI

struct PageView<Content: View, Title: View>: View {
    
    @ViewBuilder let content: () -> Content
    @ViewBuilder let title: () -> Title
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        content()
            .background(
                BackgroundSurface()
                    .ignoresSafeArea()
            )
            .safeAreaInset(edge: .top) {
                title()
                    .fixedSize(horizontal: false, vertical: true)
            }
        .background(themeManager.currentTheme.background)
    }
}
