//
//  DashboardView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

struct DashboardView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        NavigationStack {
            Text("івів")
                .navigationTitle("Dashboard")
        }
        .background(themeManager.currentTheme.background)
    }
}

#Preview {
    DashboardView()
        .environment(ThemeManager())
}
