//
//  Decimal+Hodl.swift
//  MyHodl
//
//  Created by DarkSatyr on 17.11.2025.
//

import Foundation

enum PriceDirection {
    case up
    case down
    case neutral
}

extension Decimal {
    var priceDirection: PriceDirection {
        self > 0 ? .up : (self < 0 ? .down : .neutral)
    }
    
    static func decimalWithCurrentLocale(string: String) -> Decimal? {
        Decimal(string: string, locale: Locale.current)
    }
    
    static func decimalWithCurrentLocale(string: String, fallback: Decimal) -> Decimal {
        decimalWithCurrentLocale(string: string) ?? fallback
    }
    
    var stringValue: String { "\(self)" }
    
    var isValid: Bool { isNaN == false }
}
