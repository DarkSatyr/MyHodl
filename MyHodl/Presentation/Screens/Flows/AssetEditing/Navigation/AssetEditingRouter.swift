//
//  AssetEditingRouter.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.03.2026.
//

import Foundation
import SwiftUI

final class AssetEditingRouter: ObservableObject {

    private let onClose: () -> Void

    init(onClose: @escaping () -> Void) {
        self.onClose = onClose
    }

    enum Destination: Hashable {
        case assetSelected(AssetID?)
    }

    @Published var path = [Destination]()

    func push(destination: Destination) {
        path.append(destination)
    }

    func close() {
        onClose()
    }
}
