//
//  ThemeManager.swift
//  MyHodl
//
//  Created by DarkSatyr on 23.10.2025.
//

import SwiftUI

enum ThemeType: String {
    case system
    case dark
    case light
}

@MainActor
@Observable
class ThemeManager {
    
    var currentTheme: Theme
    private static let key = "theme.type"
    
    init() {
        currentTheme = Self.preferredTheme()
    }
    
    func setThemeType(_ type: ThemeType) {
        Self.saveThemeType(type)
        currentTheme = Self.preferredTheme()
    }
    
    func updateSystemScheme(_ scheme: ColorScheme) {
        if Self.readThemeType() != .system {
            return
        }
        currentTheme = Self.preferredTheme(scheme: scheme)
    }
    
    func preferredSystemScheme() -> ColorScheme? {
        switch Self.readThemeType() {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
    
    private static func readThemeType() -> ThemeType {
        let saved = (UserDefaults.standard.string(forKey: key)).flatMap { ThemeType(rawValue: $0) }
        return saved ?? .system
    }
    
    private static func saveThemeType(_ type: ThemeType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
    }
    
    private static func preferredTheme(scheme: ColorScheme? = nil) -> Theme {
        let type = readThemeType()
        return theme(for: type, scheme: scheme)
    }
    
    private static func systemScheme() -> ColorScheme {
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            return .dark
        case .light:
            return .light
        default:
            return .dark
        }
    }
    
    private static func theme(for type: ThemeType, scheme: ColorScheme? = nil) -> Theme {
        switch type {
        case .dark:
            return DarkTheme()
        case .light:
            return LightTheme()
        case .system:
            return defaultTheme(scheme: scheme)
        }
    }
    
    private static func defaultTheme(scheme: ColorScheme? = nil) -> Theme {
        let systemScheme = scheme ?? systemScheme()
        switch systemScheme {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        default:
            return DarkTheme()
        }
    }
}
