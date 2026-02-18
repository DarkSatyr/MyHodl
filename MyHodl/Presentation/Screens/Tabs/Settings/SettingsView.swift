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
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.settingsPath) {
            PageView(content: {
                List {
                    Section {
                        NavigationLink(value: AppRouter.Destination.settingsChangeTheme) {
                            LabeledContent {
                                Text(themeManager.type.name)
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                            } label: {
                                Label(L10n.theme, systemImage: "paintbrush.fill")
                                    .foregroundStyle(themeManager.currentTheme.text)
                            }
                        }
                        .listRowBackground(themeManager.currentTheme.card)
                    } header: {
                        Text(L10n.themeVisualAppearence)
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                    }
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }, title: {
                TitleView {
                    Text(L10n.settings)
                } right: {}
            })
            .navigationDestination(for: AppRouter.Destination.self) { destination in
                switch destination {
                case .settingsChangeTheme:
                    ThemeSettingsView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager())
}
