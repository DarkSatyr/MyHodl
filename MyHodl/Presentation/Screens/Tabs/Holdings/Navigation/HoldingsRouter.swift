//
//  HoldingsRouter.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.03.2026.
//

import Foundation
import SwiftUI

final class HoldingsRouter: ObservableObject {

    enum Sheet: Identifiable, Hashable {
        case assetEdit(DashboardAsset)
        case assetAdd

        var id: Self { self }
    }

    @Published var sheet: Sheet?

    private(set) var assetEditingRouter: AssetEditingRouter?

    func presentAssetEditing(_ asset: DashboardAsset) {
        assetEditingRouter = AssetEditingRouter { [weak self] in
            self?.dismissSheet()
        }
        sheet = .assetEdit(asset)
    }

    func presentAssetAdd() {
        assetEditingRouter = AssetEditingRouter{ [weak self] in
            self?.dismissSheet()
        }
        sheet = .assetAdd
    }

    func dismissSheet() {
        sheet = nil
        assetEditingRouter = nil
    }
}
