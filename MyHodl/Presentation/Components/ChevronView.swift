//
//  ChevronView.swift
//  MyHodl
//
//  Created by DarkSatyr on 04.02.2026.
//

import SwiftUI

struct ChevronView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        IconView(source: .system(symbol: "chevron.forward"))
            .foregroundStyle(themeManager.currentTheme.accent)
            .frame(width: 16, height: 16)
    }
}

#Preview {
    ChevronView()
        .environment(ThemeManager())
}
