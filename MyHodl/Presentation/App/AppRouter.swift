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
    
    enum Destination: Hashable {
        case settingsChangeTheme
    }
    
    @Published var selectedTab = AppRouter.Tab.dashboard
    @Published var settingsPath = [Destination]()
    
    func push(destination: Destination, inTab tab: Tab? = nil) {
        let tab = tab ?? selectedTab
        switch tab {
        case .dashboard:
            break
        case .holdings:
            break
        case .settings:
            settingsPath.append(destination)
        }
    }
}
