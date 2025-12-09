//
//  Theme.swift
//  MyHodl
//
//  Created by DarkSatyr on 23.10.2025.
//

import SwiftUI

enum ThemeType: String, CaseIterable {
    case system
    case dark
    case light
    
    var name: String {
        switch self {
        case .system:
            return L10n.themeSystem
        case .dark:
            return L10n.themeDark
        case .light:
            return L10n.themeLight
        }
    }
    
    var subtitle: String {
        switch self {
        case .system:
            return L10n.themeSystemDesc
        case .dark:
            return L10n.themeDarkDesc
        case .light:
            return L10n.themeLightDesc
        }
    }
}

protocol Theme {
    // Font
    var font: Font { get }
    var subtitleFont: Font { get }
    // Color
    var background: Color { get }
    var text: Color { get }
    var textSecondary: Color { get }
    var card: Color { get }
    
    func color(change: Decimal?) -> Color
}

struct DarkTheme: Theme {
}

struct LightTheme: Theme {
}

extension Theme {
    // Font
    var font: Font { Font.system(size: 16) }
    var subtitleFont: Font { Font.system(size: 14) }
    var headerFont: Font { Font.system(size: 34, weight: .bold) }
    var highlightedFont: Font { Font.system(size: 20, weight: .bold) }
    var sectionHeaderFont: Font { Font.system(size: 17, weight: .semibold) }
    var sectionTextFont: Font { Font.system(size: 17, weight: .semibold) }
    // Color
    var background: Color { Color.background }
    var text: Color { Color.text }
    var textSecondary: Color { Color.textSecondary }
    var card: Color { Color.card }
    var accent: Color { Color.accent }
    var accentPressed: Color { Color.accentPressed }
    var searchBarBackground: Color { Color.background.opacity(0.7) }
    var searchBarSearchIcon: Color { Color.textSecondary.opacity(0.8) }
    var buttonBackground: Color { Color.background.opacity(0.7) }
    func color(change: Decimal?) -> Color {
        let direction = change?.priceDirection ?? .neutral
        switch direction {
        case .up:
            return .positive
        case .down:
            return .negative
        case .neutral:
            return .accent
        }
    }
    // Radius
    var buttonCornerRadius: CGFloat { 24 }
}
