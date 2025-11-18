//
//  CryptoPrecision.swift
//  MyHodl
//
//  Created by DarkSatyr on 17.11.2025.
//

import Foundation

enum CryptoPrecision {
    
    struct Info {
        let amountDigits: Int
    }
    
    // MARK: - Public API
    
    static func amountDigits(for symbol: String) -> Int {
        let key = symbol.uppercased()
        return amountTable[key]?.amountDigits ?? fallback.amountDigits
    }
    
    static func priceDigits(for symbol: String, and price: Decimal) -> Int {
        let v = price.magnitude
        if v >= 1000 { return 2 }
        if v >= 1 { return 4 }
        if v >= 0.01 { return 6 }
        if v >= 0.0001 { return 8 }
        return 10
    }
    
    // MARK: - Internal
    
    private static let fallback = Info(amountDigits: 8)
    
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
        set(fiat, 2)
        
        // Інші популярні L1 / L2 (типово 6 або 8)
        set([
            "ADA", "XRP", "ALGO", "ATOM", "XTZ", "XLM", "TRX", "EOS",
            "SOL", "MATIC", "AVAX", "NEO", "ONT", "VET"
        ], 6)
        
        return t
    }()
    
    private static let fiat = ["USD", "UAH", "EUR", "GBP"]
}
