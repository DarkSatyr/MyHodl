//
//  AssetRepository.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

protocol AssetRepository {
    func getAllAssets() async -> [Asset]
    func searchAssets(text: String) async -> [Asset]
}
