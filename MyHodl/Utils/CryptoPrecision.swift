//
//  CryptoPrecision.swift
//  MyHodl
//
//  Created by DarkSatyr on 17.11.2025.
//

import Foundation

/// Централізоване джерело precision для криптовалют.
/// MVP-варіант:
/// - amountDigits: ближче до реальних on-chain decimals для популярних монет
/// - priceDigits: рахується динамічно від ціни (без великого хардкоду)
enum CryptoPrecision {
    
    struct Info {
        let amountDigits: Int
    }
    
    // MARK: - Public API
    
    static func amountDigits(for symbol: String) -> Int {
        let key = symbol.uppercased()
        return amountTable[key]?.amountDigits ?? fallback.amountDigits
    }
    
    /// Скільки знаків показувати для ЦІНИ — динамічно від величини.
    /// Це не “реальний” tickSize біржі, але виглядає дуже природно.
    static func priceDigits(for price: Decimal) -> Int {
        let v = NSDecimalNumber(decimal: price).doubleValue
        switch abs(v) {
        case _ where v >= 1000:    return 2
        case _ where v >= 1:       return 4
        case _ where v >= 0.01:    return 6
        case _ where v >= 0.0001:  return 8
        default:                   return 10
        }
    }
    
    // MARK: - Internal
    
    private static let fallback = Info(amountDigits: 8)
    
    /// Таблиця amountDecimals для основних монет.
    /// (вибірка реальних значень для популярних активів;
    /// решта — fallback 8)
    private static let amountTable: [String: Info] = {
        var t: [String: Info] = [:]
        
        func set(_ symbols: [String], _ digits: Int) {
            symbols.forEach { t[$0.uppercased()] = Info(amountDigits: digits) }
        }
        
        // Класичні UTXO-монети (8 dec) — їх у тебе дуже багато у списку:
        set([
            "BTC", "LTC", "ZEC", "DASH", "BTG", "BCH", "BSV",
            "DOGE", "DGB", "VTC", "GRS", "NAV", "NEBL", "PIVX",
            "ZCL", "ZEN", "XZC", "BTX", "BTCP", "BTCD", "BLK",
            "BURST", "XMY", "XMG", "XVC", "XWC", "GAME", "MONA"
        ], 8)
        
        // Ethereum и ERC-20 стандарт (18 dec по протоколу)
        set([
            "ETH", "AAVE", "MKR", "SNX", "COMP", "UNI", "SUSHI", "YFI",
            "LINK", "GRT", "BAT", "ZRX", "KNC", "LRC", "GNT", "GNO",
            "ANT", "ENJ", "MANA", "CRV", "BAL", "1INCH", "ANKR",
            "USDT-ERC20", "USDC-ERC20", "DAI", "WBTC", "WETH"
        ], 18)
        
        // Стейблкоїни з 6 dec (Tether/USDC зазвичай 6, деякі DAI-пули 18)
        set([
            "USDT", "USDC", "TUSD", "PAX", "BUSD", "GUSD", "HUSD", "USDP"
        ], 6)
        
        // Fiat
        set([
            "USD", "UAH", "EUR", "GBP"
        ], 2)
        
        // Інші популярні L1 / L2 (типово 6 або 8)
        set([
            "ADA", "XRP", "ALGO", "ATOM", "XTZ", "XLM", "TRX", "EOS",
            "SOL", "MATIC", "AVAX", "NEO", "ONT", "VET"
        ], 6)
        
        // Якщо хочеш — сюди ж можна руками додавати рідкі монети з твого списку,
        // коли буде час/настрій, або напівавтоматним скриптом з CoinGecko.
        
        return t
    }()
}
