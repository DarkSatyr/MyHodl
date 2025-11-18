//
//  FiatSymbol.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import Foundation

enum FiatSymbol: String {
    case usd = "$"
    case eur = "€"
    case gbp = "£"
    case uah = "₴"
    
    static func symbol(for code: String) -> String {
        switch code.uppercased() {
        case "USD":
            return "$"
        case "EUR": 
            return "€"
        case "GBP":
            return "£"
        case "UAH":
            return "₴"
        default:
            return code.uppercased()
        }
    }
    
    static let fiatCurrencies = [
        "USD", "EUR", "GBP", "UAH"
    ]
    
    static func isFiatSymbol(_ symbol: String) -> Bool {
        fiatCurrencies.contains(symbol.uppercased())
    }
}
