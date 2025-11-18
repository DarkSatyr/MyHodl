//
//  StubDataModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import Foundation

enum AssetType {
    case fiat
    case crypto
}

struct Asset {
    let code: String
    let fullName: String
    let type: AssetType
    let startingPrice: Decimal
    let currentPrice: Decimal
    let amount: Decimal
    let icon: String?
}

class StubDataModel {
    let assets: [Asset]
    init() {
        assets = [
            Asset(code: "BTC",
                  fullName: "Bitcoin",
                  type: .crypto,
                  startingPrice: Decimal(string: "100000")!,
                  currentPrice: Decimal(string: "107120")!,
                  amount: Decimal(string: "1.2")!,
                  icon: "btc"),
            
            Asset(code: "ETH",
                  fullName: "Ethereum",
                  type: .crypto,
                  startingPrice: Decimal(string: "500")!,
                  currentPrice: Decimal(string: "3320")!,
                  amount: Decimal(string: "0.125")!,
                  icon: "eth"),
            
            Asset(code: "XRP",
                  fullName: "Ripple",
                  type: .crypto,
                  startingPrice: Decimal(string: "0.4")!,
                  currentPrice: Decimal(string: "2.56")!,
                  amount: Decimal(string: "1200.56")!,
                  icon: "xrp"),
            
            Asset(code: "ZEC",
                  fullName: "Zcash",
                  type: .crypto,
                  startingPrice: Decimal(string: "70")!,
                  currentPrice: Decimal(string: "450")!,
                  amount: Decimal(string: "11.8")!,
                  icon: "zec"),
            
            Asset(code: "ADA",
                  fullName: "Cardano",
                  type: .crypto,
                  startingPrice: Decimal(string: "0.3")!,
                  currentPrice: Decimal(string: "0.51")!,
                  amount: Decimal(string: "110")!,
                  icon: "ada"),
            
            Asset(code: "NEO",
                  fullName: "Neo",
                  type: .crypto,
                  startingPrice: Decimal(string: "100")!,
                  currentPrice: Decimal(string: "4.51")!,
                  amount: Decimal(string: "100")!,
                  icon: "neo"),
            
            Asset(code: "Pepe",
                  fullName: "PEPE",
                  type: .crypto,
                  startingPrice: Decimal(string: "0.000003")!,
                  currentPrice: Decimal(string: "0.0000041")!,
                  amount: Decimal(string: "10010")!,
                  icon: "pepe"),
            
            Asset(code: "USD",
                  fullName: "United States Dollar",
                  type: .fiat,
                  startingPrice: Decimal(string: "1")!,
                  currentPrice: Decimal(string: "1")!,
                  amount: Decimal(string: "1200")!,
                  icon: "usd"),
            
            Asset(code: "UAH",
                  fullName: "Ukrainian Hryvnia",
                  type: .fiat,
                  startingPrice: Decimal(string: "0.025")!,
                  currentPrice: Decimal(string: "0.023")!,
                  amount: Decimal(string: "631.21")!,
                  icon: nil),
        ]
    }
}
