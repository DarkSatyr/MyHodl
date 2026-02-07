//
//  Asset.swift
//  MyHodl
//
//  Created by DarkSatyr on 06.02.2026.
//

import Foundation

struct Asset {
    let code: String
    let fullName: String
    let amount: Decimal
    let startingPrice: Decimal?
    let currentPrice: Decimal?
}

extension Asset {
    func copy(code: String? = nil,
              fullName: String? = nil,
              amount: Decimal? = nil,
              startingPrice: Decimal? = nil,
              currentPrice: Decimal? = nil) -> Asset {
        
        Asset(code: code ?? self.code,
              fullName: fullName ?? self.fullName,
              amount: amount ?? self.amount,
              startingPrice: startingPrice ?? self.startingPrice,
              currentPrice: currentPrice ?? self.currentPrice)
    }
}
