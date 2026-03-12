//
//  AssetEditorScreen.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.02.2026.
//

import SwiftUI
import SwiftData

struct AssetEditorScreen: View {

    enum ScreenType {
        case select
        case edit(DashboardAsset)
    }

    @Environment(ThemeManager.self) private var themeManager
    @Environment(AppContainer.self) private var appContainer
    @StateObject private var router: AssetEditingRouter
    private let screenType: ScreenType

    init(screenType: ScreenType,
         router: AssetEditingRouter) {
        self.screenType = screenType
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                switch screenType {
                case .select:
                    AssetSelectView(viewModel: appContainer.makeAssetSelectViewModel(),
                                    router: router)
                case .edit(let asset):
                    AssetEditorView(
                        viewModel: appContainer.makeAssetEditorViewModel(mode: .edit(asset)),
                        router: router
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { [weak router] in // TODO: Add loc
                        router?.close()
                    }
                    .foregroundStyle(themeManager.currentTheme.text)
                }
            }
            .navigationDestination(for: AssetEditingRouter.Destination.self) { destination in
                switch destination {
                case .assetSelected(let asset):
                    AssetEditorView(
                        viewModel: appContainer.makeAssetEditorViewModel(mode: .create(asset)),
                        router: router
                    )
                }
            }
        }
    }
}

#Preview {
    AssetEditorScreen(
        screenType: .select,
        router: AssetEditingRouter {}
    )
    .environment(ThemeManager())
}
