//
//  ContentView.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.08.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .background(themeManager.currentTheme.background)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
