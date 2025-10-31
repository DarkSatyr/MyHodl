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
            return "System"
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        }
    }
    
    var subtitle: String {
        switch self {
        case .system:
            return "Follow device settings"
        case .dark:
            return "Dimmed appearance, comfortable at night"
        case .light:
            return "Bright appearance with maximum contrast"
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
}

struct DarkTheme: Theme {
}

struct LightTheme: Theme {
}

extension Theme {
    // Font
    var font: Font { Font.system(size: 16) }
    var subtitleFont: Font { Font.system(size: 14) }
    // Color
    var background: Color { Color.background }
    var text: Color { Color.text }
    var textSecondary: Color { Color.textSecondary }
    var card: Color { Color.card }
}
