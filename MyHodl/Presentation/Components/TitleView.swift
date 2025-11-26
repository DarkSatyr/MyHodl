//
//  TitleView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct TitleView<Left: View, Right: View>: View {
    @Environment(ThemeManager.self) private var themeManager
    @ViewBuilder let left: () -> Left
    @ViewBuilder let right: () -> Right
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            left()
                .font(themeManager.currentTheme.headerFont)
                .foregroundStyle(themeManager.currentTheme.text)
            Spacer()
            right()
                .font(.headline).foregroundStyle(.secondary)
                .foregroundStyle(themeManager.currentTheme.text)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }
}

#Preview {
    TitleView {
        Text("Some Label")
    } right: {
        Text("12 Nov. 2025")
    }
    .environment(ThemeManager())
}
