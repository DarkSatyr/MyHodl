//
//  DashboardAsset.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import Foundation

struct DashboardAsset: Identifiable {
    let code: String
    let fullName: String
    let icon: ImageSource
    let currentPrice: Decimal
    let previousPrice: Decimal
    let amount: Decimal
    var id: String { code }
    
    var changePercent: Decimal? {
        guard previousPrice != 0 else { return nil }
        return (currentPrice - previousPrice) / previousPrice
    }
    
    var totalEntry: Decimal {
        previousPrice * amount
    }
    
    var totalCurrent: Decimal {
        currentPrice * amount
    }
}
