//
//  MyHoldingsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

struct MyHoldingsView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle("My Holdings")
        }
        .background(themeManager.currentTheme.background)
    }
}

#Preview {
    MyHoldingsView()
        .environment(ThemeManager())
}
