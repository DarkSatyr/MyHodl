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
    let startingPrice: String
    let currentPrice: String
    let amount: String
    let icon: String?
}

class StubDataModel {
    let assets: [Asset]
    init() {
        assets = [
            Asset(code: "BTC", fullName: "Bitcoin", type: .crypto, startingPrice: "100000", currentPrice: "107120", amount: "1.2", icon: "btc"),
            Asset(code: "ETH", fullName: "Ethereum", type: .crypto, startingPrice: "500", currentPrice: "3320", amount: "0.125", icon: "eth"),
            Asset(code: "XRP", fullName: "Ripple", type: .crypto, startingPrice: "0.4", currentPrice: "2.56", amount: "1200.56", icon: "xrp"),
            Asset(code: "ZEC", fullName: "Zcash", type: .crypto, startingPrice: "70", currentPrice: "450", amount: "11.8", icon: "zec"),
            Asset(code: "USD", fullName: "United States Dollar", type: .fiat, startingPrice: "1", currentPrice: "1", amount: "1200", icon: "usd"),
            Asset(code: "UAH", fullName: "Ukrainian Hryvnia", type: .fiat, startingPrice: "40", currentPrice: "43", amount: "631.21", icon: nil),
        ]
    }
}
