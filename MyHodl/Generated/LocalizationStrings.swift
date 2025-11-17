// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Asset Allocation
  public static let assetAllocation = L10n.tr("Localizable", "Asset Allocation", fallback: "Asset Allocation")
  /// Discard
  public static let buttonDiscard = L10n.tr("Localizable", "button_discard", fallback: "Discard")
  /// Crypto
  public static let crypto = L10n.tr("Localizable", "Crypto", fallback: "Crypto")
  /// Dashboard
  public static let dashboard = L10n.tr("Localizable", "Dashboard", fallback: "Dashboard")
  /// Fiat
  public static let fiat = L10n.tr("Localizable", "Fiat", fallback: "Fiat")
  /// Holdings
  public static let holdings = L10n.tr("Localizable", "Holdings", fallback: "Holdings")
  /// My Holdings
  public static let myHoldings = L10n.tr("Localizable", "My Holdings", fallback: "My Holdings")
  /// Localizable.strings
  ///   MyHodl
  /// 
  ///   Created by DarkSatyr on 10.11.2025.
  public static let settings = L10n.tr("Localizable", "settings", fallback: "Settings")
  /// Theme
  public static let theme = L10n.tr("Localizable", "theme", fallback: "Theme")
  /// Dark
  public static let themeDark = L10n.tr("Localizable", "theme_dark", fallback: "Dark")
  /// Dimmed appearance, comfortable at night
  public static let themeDarkDesc = L10n.tr("Localizable", "theme_dark_desc", fallback: "Dimmed appearance, comfortable at night")
  /// Light
  public static let themeLight = L10n.tr("Localizable", "theme_light", fallback: "Light")
  /// Bright appearance with maximum contrast
  public static let themeLightDesc = L10n.tr("Localizable", "theme_light_desc", fallback: "Bright appearance with maximum contrast")
  /// Select Theme
  public static let themeSelect = L10n.tr("Localizable", "theme_select", fallback: "Select Theme")
  /// System
  public static let themeSystem = L10n.tr("Localizable", "theme_system", fallback: "System")
  /// Follow device settings
  public static let themeSystemDesc = L10n.tr("Localizable", "theme_system_desc", fallback: "Follow device settings")
  /// Visual Appearance
  public static let themeVisualAppearence = L10n.tr("Localizable", "theme_visual_appearence", fallback: "Visual Appearance")
  /// Top Holdings
  public static let topHoldings = L10n.tr("Localizable", "Top Holdings", fallback: "Top Holdings")
  /// Total Balance
  public static let totalBalance = L10n.tr("Localizable", "Total Balance", fallback: "Total Balance")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
