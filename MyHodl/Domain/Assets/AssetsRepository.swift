//
//  AssetsRepository.swift
//  MyHodl
//
//  Created by DarkSatyr on 06.02.2026.
//

import Foundation
import Combine

protocol AssetsRepository {
    func save(_ asset: Asset) throws
    func observeAssets() -> AnyPublisher<[Asset], Never>
    func asset(code: String) throws -> Asset?
    func delete(_ id: String) throws
}
