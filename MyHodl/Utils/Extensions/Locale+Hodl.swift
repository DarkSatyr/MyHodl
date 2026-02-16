//
//  Locale+Hodl.swift
//  MyHodl
//
//  Created by DarkSatyr on 16.02.2026.
//

import Foundation

extension Locale {
    static var decimalSeparatorCharacter: Character {
        Locale.current.decimalSeparator?.first ?? "."
    }
}

enum AppLocale {
    static let decimalSeparator: Character = Locale.decimalSeparatorCharacter
}
