//
//  DashboardRouter.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.03.2026.
//

import Foundation
import SwiftUI

final class DashboardRouter: ObservableObject {

    enum Sheet: Identifiable, Hashable {
        case assetAdd

        var id: Self { self }
    }

    @Published var sheet: Sheet?
    private(set) var assetEditingRouter: AssetEditingRouter?

    func presentAssetAdd() {
        assetEditingRouter = AssetEditingRouter { [weak self] in
            self?.dismissSheet()
        }
        sheet = .assetAdd
    }

    func dismissSheet() {
        sheet = nil
        assetEditingRouter = nil
    }
}
