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
