//
//  SearchBar.swift
//  MyHodl
//
//  Created by DarkSatyr on 18.11.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    @FocusState private var isFocused: Bool
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(themeManager.currentTheme.textSecondary)

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .submitLabel(.done)
                .foregroundStyle(themeManager.currentTheme.text)
                .focused($isFocused)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(themeManager.currentTheme.searchBarSearchIcon)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            themeManager.currentTheme.searchBarBackground
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
