//
//  Formatters.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.11.2025.
//

import Foundation

// MARK: - Price Formatting

let baseCurrency = "usd"

enum AmountFormat {
    
    static func amount(_ amount: Decimal?, currency: String) -> String {
        guard let amount else { return "-" }
        return CryptoFormat.crypto(amount, currency: currency)
    }
    
    static func percent(_ value: Decimal?) -> String {
        guard let value else { return "-" }
        return Percent.format(value)
    }
}

enum PriceFormat {
    
    static func price(_ price: Decimal?, currency: String) -> String {
        guard let price else { return "-" }
        return CryptoFormat.crypto(price, currency: currency)
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

    static func format(_ value: Decimal) -> String {
        formatter.string(for: value) ?? "0%"
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
enum CryptoFormat {
    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 8 // BTC precision
        return f
    }()

    static func crypto(_ value: Decimal, currency: String) -> String {
        formatter.string(for: value) ?? "0"
    }
}
