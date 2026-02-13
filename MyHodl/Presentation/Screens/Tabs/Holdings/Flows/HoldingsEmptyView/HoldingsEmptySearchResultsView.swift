//
//  HoldingsEmptySearchResultsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.02.2026.
//

import SwiftUI

struct HoldingsEmptySearchResultsView: View {
    
    var onButtonClear: () -> ()
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 28, height: 28)
                .opacity(0.6)
                .foregroundStyle(themeManager.currentTheme.text)
                .font(themeManager.currentTheme.subtitleFont)
            VStack {
                Text("No results")
                    .foregroundStyle(themeManager.currentTheme.text)
                    .font(themeManager.currentTheme.font)
                Text("Try a different search term")
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                    .font(themeManager.currentTheme.subtitleFont)
            }
            Button(action: {
                onButtonClear()
            }, label: {
                Text("Clear")
                    .foregroundStyle(themeManager.currentTheme.accent.opacity(0.8))
            })
            .padding(.top, 6)
        }
    }
}

#Preview {
    HoldingsEmptySearchResultsView {}
        .environment(ThemeManager())
}
