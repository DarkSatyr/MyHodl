//
//  SettingsRouter.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.03.2026.
//

import Foundation
import SwiftUI

final class SettingsRouter: ObservableObject {

    enum Destination: Hashable {
        case settingsChangeTheme
    }

    @Published var path = [Destination]()

    func push(destination: Destination) {
        path.append(destination)
    }
}
