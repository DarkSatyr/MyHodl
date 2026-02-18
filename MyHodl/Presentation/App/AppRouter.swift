//
//  AppRouter.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.02.2026.
//

import Foundation
import SwiftUI

@MainActor
final class AppRouter: ObservableObject {
    
    enum Tab: Hashable {
        case dashboard, holdings, settings
    }
    
    @Published var selectedTab = AppRouter.Tab.dashboard
}
