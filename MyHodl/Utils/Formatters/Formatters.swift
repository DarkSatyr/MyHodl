//
//  Formatters.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.11.2025.
//

import Foundation

// MARK: - Price Formatting

let baseCurrency = "USD"

@MainActor
enum AmountFormat {
    static func amount(_ amount: Decimal?, currency: String) -> String {
        guard let amount else { return "-" }
        return CryptoFormat.amount(amount, currency: currency)
    }
    
    static func percentChange(_ value: Decimal?) -> String {
        guard let value else { return "-" }
        return Percent.formatChange(value)
    }
    
    static func percent(_ value: Decimal?) -> String {
        guard let value else { return "-" }
        return Percent.formatAmount(value)
    }
}

@MainActor
enum PriceFormat {
    static func price(_ price: Decimal?, currency: String) -> String {
        guard let price else { return "-" }
        return CryptoFormat.price(price, currency: currency)
    }
}

@MainActor
enum Percent {
    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 2
        f.minimumFractionDigits = 0
        f.positivePrefix = "+"
        return f
    }()

    static func formatChange(_ value: Decimal) -> String {
        formatter.positivePrefix = "+"
        return formatter.string(for: value) ?? "0%"
    }
    
    static func formatAmount(_ value: Decimal) -> String {
        formatter.positivePrefix = ""
        return formatter.string(for: value) ?? "0%"
    }
}

@MainActor
enum CryptoFormat {
    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 8 // BTC precision
        return f
    }()

    static func amount(_ value: Decimal, currency: String) -> String {
        formatter.maximumFractionDigits = CryptoPrecision.amountDigits(for: currency.lowercased())
        return formatter.string(for: value) ?? "0"
    }
    
    static func price(_ value: Decimal, currency: String) -> String {
        formatter.maximumFractionDigits = CryptoPrecision.priceDigits(for: currency.lowercased(), and: value)
        return formatter.string(for: value) ?? "0"
    }
}

@MainActor
enum DateFormat {
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMMM dd, yyyy"
        return f
    }()
    
    static func date(_ value: Date) -> String {
        formatter.string(from: value)
    }
    
    static func today() -> String {
        date(Date())
    }
}
