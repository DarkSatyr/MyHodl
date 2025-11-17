//
//  Formatters.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.11.2025.
//

import Foundation

// MARK: - Price Formatting

enum PriceFormat {
    static func change(start: Decimal, current: Decimal) -> String? {
        guard start != 0 else { return nil }
        let change = (current - start) / start
        return Percent.format(change)
    }
    
    static func change(start: String, current: String) -> String? {
        guard let start = Decimal(string: start),
              let current = Decimal(string: current) else {
            return nil
        }
        return change(start: start, current: current)
    }
}

// MARK: - Percent Formatting
enum Percent {
    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 2
        f.minimumFractionDigits = 0
        f.positivePrefix = "+"
        return f
    }()

    static func format(_ value: Decimal) -> String? {
        formatter.string(for: value)
    }
}

// MARK: - Fiat Formatting (USD, EUR, etc)
enum Fiat {
    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = "USD"
        f.maximumFractionDigits = 2
        return f
    }()

    static func format(_ amount: Decimal, currency: String = "USD") -> String {
        formatter.currencyCode = currency
        return formatter.string(for: amount) ?? "--"
    }
}

//// MARK: - Crypto Formatting (BTC, ETH, Satoshis)
//enum CryptoFormat {
//    private static let btcFormatter: NumberFormatter = {
//        let f = NumberFormatter()
//        f.minimumFractionDigits = 0
//        f.maximumFractionDigits = 8 // BTC precision
//        return f
//    }()
//
//    static func btc(_ value: Decimal) -> String {
//        btcFormatter.string(for: value) ?? "0"
//    }
//}
