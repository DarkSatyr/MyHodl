//
//  StubDataModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import Foundation
@preconcurrency import Combine

struct Asset1 {
    let code: String
    let fullName: String
    let startingPrice: Decimal
    let currentPrice: Decimal
    let amount: Decimal
    let icon: ImageSource
}

final class StubDataModel: Sendable {
    
    static let shared = StubDataModel()
    let assets = CurrentValueSubject<[Asset1], Never>([])
    
    func addAsset(_ asset: Asset1) {
        var currentAssets = assets.value
        currentAssets.append(asset)
        assets.send(currentAssets)
    }
    
    private init() {
//        assets = [
//            Asset1(code: "BTC",
//                  fullName: "Bitcoin",
//                  startingPrice: Decimal(string: "100000")!,
//                  currentPrice: Decimal(string: "107120")!,
//                  amount: Decimal(string: "1.2")!,
//                  icon: "btc"),
//            
//            Asset1(code: "ETH",
//                  fullName: "Ethereum",
//                  startingPrice: Decimal(string: "500")!,
//                  currentPrice: Decimal(string: "3320")!,
//                  amount: Decimal(string: "0.125")!,
//                  icon: "eth"),
//            
//            Asset1(code: "XRP",
//                  fullName: "Ripple",
//                  startingPrice: Decimal(string: "0.4")!,
//                  currentPrice: Decimal(string: "2.56")!,
//                  amount: Decimal(string: "1200.56")!,
//                  icon: "xrp"),
//            
//            Asset1(code: "ZEC",
//                  fullName: "Zcash",
//                  startingPrice: Decimal(string: "70")!,
//                  currentPrice: Decimal(string: "450")!,
//                  amount: Decimal(string: "11.8")!,
//                  icon: "zec"),
//            
//            Asset1(code: "ADA",
//                  fullName: "Cardano",
//                  startingPrice: Decimal(string: "0.3")!,
//                  currentPrice: Decimal(string: "0.51")!,
//                  amount: Decimal(string: "110")!,
//                  icon: "ada"),
//            
//            Asset1(code: "NEO",
//                  fullName: "Neo",
//                  startingPrice: Decimal(string: "100")!,
//                  currentPrice: Decimal(string: "4.51")!,
//                  amount: Decimal(string: "100")!,
//                  icon: "neo"),
//            
//            Asset1(code: "Pepe",
//                  fullName: "PEPE",
//                  startingPrice: Decimal(string: "0.000003")!,
//                  currentPrice: Decimal(string: "0.0000041")!,
//                  amount: Decimal(string: "10010")!,
//                  icon: "pepe"),
//            
//            Asset1(code: "USD",
//                  fullName: "United States Dollar",
//                  startingPrice: Decimal(string: "1")!,
//                  currentPrice: Decimal(string: "1")!,
//                  amount: Decimal(string: "1200")!,
//                  icon: "usd"),
//            
//            Asset1(code: "UAH",
//                  fullName: "Ukrainian Hryvnia",
//                  startingPrice: Decimal(string: "0.025")!,
//                  currentPrice: Decimal(string: "0.023")!,
//                  amount: Decimal(string: "631.21")!,
//                  icon: nil),
//        ]
    }
}
