//
//  BaseButton.swift
//  MyHodl
//
//  Created by DarkSatyr on 04.02.2026.
//

import SwiftUI

struct BaseButton: View {
    let title: String
    var action: () -> Void
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(themeManager.currentTheme.accent)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(themeManager.currentTheme.buttonBackground)
                .clipShape(RoundedRectangle(cornerRadius: themeManager.currentTheme.buttonCornerRadius, style: .continuous))
        }
    }
}

#Preview {
    BaseButton(title: "Button", action: {})
        .environment(ThemeManager())
}
