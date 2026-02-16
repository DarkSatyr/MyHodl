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
    
    static func fiatAmountPrefixed(_ amount: Decimal?, currency: String) -> String? {
        guard let amount, let formatted = FiatFormat.amount(amount, currency: currency) else {
            return nil
        }
        return FiatSymbol.symbol(for: baseCurrency) + formatted
    }
    
    static func amount(_ amount: Decimal?, currency: String) -> String? {
        guard let amount else { return nil }
        return CryptoFormat.amount(amount, currency: currency)
    }
    
    static func percentChange(_ value: Decimal?) -> String? {
        guard let value else { return nil }
        return Percent.formatChange(value)
    }
    
    static func percent(_ value: Decimal?) -> String? {
        guard let value else { return nil }
        return Percent.formatAmount(value)
    }
}

@MainActor
enum PriceFormat {
    static func fiatPrice(_ price: Decimal?, currency: FiatSymbol) -> String? {
        guard let price else { return nil }
        return CryptoFormat.price(price, currency: currency.rawValue)
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

    static func formatChange(_ value: Decimal) -> String? {
        formatter.positivePrefix = "+"
        return formatter.string(for: value)
    }
    
    static func formatAmount(_ value: Decimal) -> String? {
        formatter.positivePrefix = ""
        return formatter.string(for: value)
    }
}

@MainActor
enum FiatFormat {
    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        f.usesGroupingSeparator = true
        return f
    }()

    static func amount(_ value: Decimal, currency: String) -> String? {
        return formatter.string(for: value)
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

    static func amount(_ value: Decimal, currency: String) -> String? {
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = CryptoPrecision.amountDigits(for: currency.lowercased())
        return formatter.string(for: value)
    }
    
    static func amountPlaceholder(_ value: Decimal, currency: String, fallback: String = "0") -> String {
        let digits = CryptoPrecision.amountDigits(for: currency.lowercased())
        formatter.minimumFractionDigits = digits
        formatter.maximumFractionDigits = digits
        return formatter.string(for: value) ?? fallback
    }
    
    static func price(_ value: Decimal, currency: String) -> String? {
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = CryptoPrecision.priceDigits(for: currency.lowercased(), and: value)
        return formatter.string(for: value)
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
