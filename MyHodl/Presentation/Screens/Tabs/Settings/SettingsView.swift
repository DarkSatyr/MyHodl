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
    @StateObject private var router: SettingsRouter

    init(router: SettingsRouter) {
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            PageView(content: {
                List {
                    Section {
                        NavigationLink(value: SettingsRouter.Destination.settingsChangeTheme) {
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
            .navigationDestination(for: SettingsRouter.Destination.self) { destination in
                switch destination {
                case .settingsChangeTheme:
                    ThemeSettingsView()
                }
            }
        }
    }
}

#Preview {
    SettingsView(router: AppRouter().settingsRouter)
        .environment(ThemeManager())
}
