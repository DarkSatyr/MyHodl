//
//  BackgroundSurface.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import SwiftUI

struct BackgroundSurface: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        RoundedRectangle(cornerRadius: 28, style: .continuous)
            .fill(surfaceColor)
    }
    
    private var surfaceColor: LinearGradient {
        LinearGradient(
            colors: [
                themeManager.currentTheme.accent.opacity(0.10),
                Color.black.opacity(0.85)
            ],
            startPoint: .bottom,
            endPoint: .topLeading
        )
    }
}
