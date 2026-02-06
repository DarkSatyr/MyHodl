//
//  AssetRecord.swift
//  MyHodl
//
//  Created by DarkSatyr on 06.02.2026.
//

import Foundation
import SwiftData

@Model
class AssetRecord {
    var code: String
    var fullName: String
    var amount: Decimal
    var startingPrice: Decimal?
    var currentPrice: Decimal?
    
    init(code: String,
         fullName: String,
         amount: Decimal,
         startingPrice: Decimal? = nil,
         currentPrice: Decimal? = nil) {
        
        self.code = code
        self.fullName = fullName
        self.amount = amount
        self.startingPrice = startingPrice
        self.currentPrice = currentPrice
    }
}

extension AssetRecord {
    func toDomain() -> Asset {
        Asset(
            code: code,
            fullName: fullName,
            amount: amount,
            startingPrice: startingPrice,
            currentPrice: currentPrice
        )
    }
}

extension AssetRecord {
    convenience init(from asset: Asset) {
        self.init(
            code: asset.code,
            fullName: asset.fullName,
            amount: asset.amount,
            startingPrice: asset.startingPrice,
            currentPrice: asset.currentPrice
        )
    }
}
