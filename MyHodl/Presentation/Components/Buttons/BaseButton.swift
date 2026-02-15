//
//  BaseButton.swift
//  MyHodl
//
//  Created by DarkSatyr on 04.02.2026.
//

import SwiftUI

enum BaseButtonType {
    case normal
    case destructive
}

struct BaseButton: View {
    let title: String
    let type: BaseButtonType
    var action: () -> Void
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(foregroundStyle)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(backgroundStyle)
                .clipShape(RoundedRectangle(cornerRadius: themeManager.currentTheme.buttonCornerRadius, style: .continuous))
        }
    }
    
    var foregroundStyle: Color {
        switch type {
        case .normal:
            return themeManager.currentTheme.accent
        case .destructive:
            return themeManager.currentTheme.textWarning
        }
    }
    
    var backgroundStyle: Color {
        switch type {
        case .normal:
            return themeManager.currentTheme.buttonBackground
        case .destructive:
            return .clear
        }
    }
}

#Preview {
    BaseButton(title: "Button", type: .normal, action: {})
        .environment(ThemeManager())
}
