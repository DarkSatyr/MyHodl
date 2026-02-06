//
//  CryptoAssetsFileLoader.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

enum CryptoAssetsFileLoaderError: Error {
    case fileNotFound(String)
}

struct CryptoAssetsFileLoader {
    func loadAssetsList() throws -> [CryptoAssetInfo] {
        let bundle = Bundle.main

        guard let url = bundle.url(forResource: "crypto_coins_list", withExtension: "json") else {
            throw CryptoAssetsFileLoaderError.fileNotFound("crypto_coins_list.json not found in bundle \(bundle)")
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([CryptoAssetInfo].self, from: data)
    }
}
