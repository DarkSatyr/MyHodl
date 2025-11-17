//
//  TitleView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct TitleView: View {
    @Environment(ThemeManager.self) private var themeManager
    var leftLabel: String
    var rightLabel: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(alignment: .lastTextBaseline) {
                    Text(leftLabel)
                        .font(themeManager.currentTheme.headerFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    Spacer()
                    Text(rightLabel)
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
    TitleView(leftLabel: "Some Label", rightLabel: "12 Nov. 2025")
        .environment(ThemeManager())
}
