//
//  ThemeSettingsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 31.10.2025.
//

import SwiftUI

struct ThemeSettingsView: View {
    @State private var selectedType: ThemeType = .system
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(ThemeType.allCases, id: \.self) { type in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.rawValue.capitalized)
                                    .foregroundStyle(themeManager.currentTheme.text)
                                    .font(themeManager.currentTheme.font)
                                Text(type.subtitle.capitalized)
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                                    .font(themeManager.currentTheme.subtitleFont)
                            }
                            Spacer()
                            if type == selectedType {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.tint)
                                    .fontWeight(.semibold)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedType = type
                            themeManager.setThemeType(type)
                        }
                    }
                }
                .listRowBackground(themeManager.currentTheme.card)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(themeManager.currentTheme.background)
            .navigationTitle("Select Theme")
        }
        .onAppear {
            selectedType = themeManager.type
        }
    }
}

#Preview {
    ThemeSettingsView()
        .environment(ThemeManager())
}
