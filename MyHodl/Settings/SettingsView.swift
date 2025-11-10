//
//  SettingsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 30.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        ThemeSettingsView()
                    } label: {
                        LabeledContent {
                            Text(themeManager.type.name)
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                        } label: {
                            Label("Тема", systemImage: "paintbrush.fill")
                                .foregroundStyle(themeManager.currentTheme.text)
                        }
                    }
                    .listRowBackground(themeManager.currentTheme.card)
                } header: {
                    Text("Visual Appearance")
                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                }
                .foregroundStyle(themeManager.currentTheme.textSecondary)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle(L10n.settings)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Скасувати", action: { dismiss() })
                        .foregroundStyle(themeManager.currentTheme.text)
                }
            }
        }
        .background(themeManager.currentTheme.background)
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager())
}
