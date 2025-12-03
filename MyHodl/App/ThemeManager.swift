//
//  ThemeManager.swift
//  MyHodl
//
//  Created by DarkSatyr on 23.10.2025.
//

import SwiftUI

@MainActor
@Observable
final class ThemeManager {
    
    var currentTheme: Theme
    var type: ThemeType
    private static let key = "theme.type"
    
    init() {
        let type = Self.readThemeType()
        currentTheme = Self.theme(for: type)
        self.type = type
    }
    
    func setThemeType(_ type: ThemeType) {
        Self.saveThemeType(type)
        currentTheme = Self.preferredTheme(type: type)
        self.type = type
    }
    
    func updateSystemScheme(_ scheme: ColorScheme) {
        if type != .system {
            return
        }
        currentTheme = Self.preferredTheme(type: type, scheme: scheme)
    }
    
    func preferredSystemScheme() -> ColorScheme? {
        switch type {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
    
    static func systemScheme() -> ColorScheme {
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            return .dark
        case .light:
            return .light
        default:
            return .dark
        }
    }
    
    private static func readThemeType() -> ThemeType {
        let saved = (UserDefaults.standard.string(forKey: key)).flatMap { ThemeType(rawValue: $0) }
        return saved ?? .system
    }
    
    private static func saveThemeType(_ type: ThemeType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
    }
    
    private static func preferredTheme(type: ThemeType, scheme: ColorScheme? = nil) -> Theme {
        theme(for: type, scheme: scheme)
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
