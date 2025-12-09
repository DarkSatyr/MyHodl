//
//  Asset.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

struct AssetID: Hashable {
    let code: String
    let name: String
}

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

extension Asset: Decodable {
    var sortRank: Int {
        rank ?? .max
    }
    
    var icon: ImageSource {
        .local(name: code)
    }
    
    var assetID: AssetID {
        AssetID(code: code, name: name)
    }
}

extension AssetType: Decodable {
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        self = AssetType(rawValue: value) ?? .unknown
    }
}
