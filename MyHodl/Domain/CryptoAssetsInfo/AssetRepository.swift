//
//  CryptoAssetInfoRepository.swift
//  MyHodl
//
//  Created by DarkSatyr on 27.11.2025.
//

import Foundation

protocol CryptoAssetInfoRepository: Sendable {
    func getAllAssets() async -> [CryptoAssetInfo]
    func searchAssets(text: String) async -> [CryptoAssetInfo]
    func topAssets(count: Int) async -> [CryptoAssetInfo] 
}
