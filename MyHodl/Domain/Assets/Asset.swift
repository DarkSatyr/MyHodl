//
//  Asset.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

public enum AssetType: String, Sendable {
    case crypto
    case fiat
    case unknown
}

public struct Asset: Identifiable, Hashable, Sendable {
    public let id: String
    let code: String
    let name: String
    let type: AssetType
    let isDead: Bool
    let coingeckoId: String?
    let rank: Int?
}

extension Asset: Decodable {}

extension AssetType: Decodable {
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        self = AssetType(rawValue: value) ?? .unknown
    }
}
