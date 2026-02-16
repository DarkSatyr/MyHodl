//
//  LimitInputTextModifier.swift
//  MyHodl
//
//  Created by DarkSatyr on 16.02.2026.
//

import SwiftUI

private struct LimitInputTextModifier: ViewModifier {
    @Binding var text: String
    let sanitize: (String) -> String

    func body(content: Content) -> some View {
        content.onChange(of: text) { _, newValue in
            let sanitized = sanitize(newValue)
            guard sanitized != newValue else { return }
            text = sanitized
        }
    }
}

extension View {
    func limitInput(_ text: Binding<String>, _ sanitize: @escaping (String) -> String) -> some View {
        modifier(LimitInputTextModifier(text: text, sanitize: sanitize))
    }
    
    func limitCurrencyDecimals(_ text: Binding<String>, currency: String) -> some View {
        modifier(LimitInputTextModifier(text: text) { text in
            DecimalInputFilter.limit(text, sep: AppLocale.decimalSeparator, maxFractionDigits: CryptoFormat.amountFractionDigits(currency: currency))
        })
    }
    
    func limitPriceDecimals(_ text: Binding<String>, price: String, currency: String) -> some View {
        modifier(LimitInputTextModifier(text: text) { text in
            guard let price = Decimal.decimalWithCurrentLocale(string: price) else { return text }
            return DecimalInputFilter.limit(text, sep: AppLocale.decimalSeparator, maxFractionDigits: CryptoFormat.priceFractionDigits(price: price, currency: currency))
        })
    }
}
