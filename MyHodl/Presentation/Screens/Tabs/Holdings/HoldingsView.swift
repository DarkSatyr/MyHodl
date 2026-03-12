//
//  HoldingsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

struct HoldingsView: View {
    @Environment(ThemeManager.self) private var themeManager
    @Environment(AppContainer.self) private var appContainer
    @StateObject private var viewModel: HoldingsViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var router: HoldingsRouter

    init(viewModel: HoldingsViewModel, router: HoldingsRouter) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        Group {
            if viewModel.isEmpty {
                HoldingsEmptyView(router: router)
            } else {
                NavigationStack {
                    PageView {
                        List {
                            SearchBar(text: $viewModel.searchText, placeholder: L10n.searchCoins)
                                .listRowInsets(.vertical, 0)
                                .listRowSeparator(.hidden)
                            HoldingsTotalBalanceView(total: viewModel.totalBalance, assetsCount: viewModel.assetsCount)
                                .listRowSeparator(.hidden)
                            if viewModel.isEmptyAssetsFilteringResults {
                                HoldingsEmptySearchResultsView {
                                    viewModel.clearSearchText()
                                }
                                .frame(maxWidth: .infinity)
                                .listRowSeparator(.hidden)
                            } else {
                                ForEach(viewModel.filteredAssets) { asset in
                                    AssetRow(asset: asset)
                                        .listRowInsets(.vertical, 6)
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .onTapGesture { [weak router] in
                                            router?.presentAssetEditing(asset)
                                        }
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    } title: {
                        TitleView {
                            Text(L10n.holdings)
                        } right: {
                            Button("Add asset", systemImage: "plus") { // TODO: Add loc
                                router.presentAssetAdd()
                            }
                            .foregroundStyle(.accent)
                        }
                    }
                }
            }
        }
        .sheet(item: $router.sheet) { destination in
            switch destination {
            case .assetAdd:
                assetEditorScreen(.select)
            case .assetEdit(let asset):
                assetEditorScreen(.edit(asset))
            }
        }
    }

    @ViewBuilder
    private func assetEditorScreen(_ screenType: AssetEditorScreen.ScreenType) -> some View {
        if let assetEditingRouter = router.assetEditingRouter {
            AssetEditorScreen(
                screenType: screenType,
                router: assetEditingRouter
            )
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    let vm = AppContainer().makeHoldingsViewModel()
    let asset = DashboardAsset(code: "BTC", fullName: "Bitcoin", icon: .placeholder, currentPrice: 67000, previousPrice: 100_000, amount: 1.2)
    vm.assets = [asset]
    return HoldingsView(viewModel: vm, router: AppRouter().holdingsRouter)
        .environment(ThemeManager())
        .environment(AppContainer())
}
