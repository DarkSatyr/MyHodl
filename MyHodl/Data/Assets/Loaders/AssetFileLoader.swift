//
//  AssetFileLoader.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

enum AssetFileLoaderError: Error {
    case fileNotFound(String)
}

struct AssetFileLoader {
    func loadAssetsList() throws -> [Asset] {
        let bundle = Bundle.main

        guard let url = bundle.url(forResource: "coins_list", withExtension: "json") else {
            throw AssetFileLoaderError.fileNotFound("coins_list.json not found in bundle \(bundle)")
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Asset].self, from: data)
    }
}
