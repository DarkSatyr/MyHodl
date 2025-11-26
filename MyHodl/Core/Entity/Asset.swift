//
//  Asset.swift
//  MyHodl
//
//  Created by DarkSatyr on 26.11.2025.
//

import Foundation

struct Asset: Codable, Identifiable, Hashable {
    let code: String
    let name: String
    let type: AssetType
    let isDead: Bool
    let coingeckoId: String?
    let id: String
    let rank: Int?
}

enum AssetType: String, Codable {
    case crypto, fiat, unknown

    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        self = AssetType(rawValue: value) ?? .unknown
    }
}
