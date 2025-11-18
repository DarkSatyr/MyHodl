//
//  TitleView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct TitleView<Left: View, Right: View>: View {
    @Environment(ThemeManager.self) private var themeManager
    @ViewBuilder var left: () -> Left
    @ViewBuilder var right: () -> Right
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(alignment: .lastTextBaseline) {
                    left()
                        .font(themeManager.currentTheme.headerFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    Spacer()
                    right()
                        .font(.headline).foregroundStyle(.secondary)
                        .foregroundStyle(themeManager.currentTheme.text)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 12)

                // далі контент…
            }
            .navigationTitle("")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TitleView {
        Text("Some Label")
    } right: {
        Text("12 Nov. 2025")
    }
    .environment(ThemeManager())
}
