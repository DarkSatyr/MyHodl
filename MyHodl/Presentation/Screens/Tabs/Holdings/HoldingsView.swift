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
    @State private var showAddAsset = false
    @State private var showEditAsset: DashboardAsset?
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: HoldingsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.isEmpty {
                HoldingsEmptyView(showAddCoin: $showAddAsset)
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
                                        .onTapGesture {
                                            showEditAsset = asset
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
                            Button("Add asset", systemImage: "plus") {  // TODO: Add loc
                                showAddAsset = true
                            }
                            .foregroundStyle(.accent)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddAsset) {
            AssetSelectView(viewModel: appContainer.makeAssetSelectViewModel())
                .interactiveDismissDisabled()
        }
        .sheet(item: $showEditAsset) { asset in
            AssetEditorScreen(viewModel: appContainer.makeAssetEditorViewModel(mode: .edit(asset)))
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    let vm = AppContainer().makeHoldingsViewModel()
    let asset = DashboardAsset(code: "BTC", fullName: "Bitcoin", icon: .placeholder, currentPrice: 67000, previousPrice: 100_000, amount: 1.2)
    vm.assets = [asset]
    return HoldingsView(viewModel: vm)
        .environment(ThemeManager())
        .environment(AppContainer())
}
