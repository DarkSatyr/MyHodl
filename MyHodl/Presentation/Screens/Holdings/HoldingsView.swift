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
    @State private var showAddCoin = false
    
    init(viewModel: HoldingsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.isEmpty {
                HoldingsEmptyView(showAddCoin: $showAddCoin)
            } else {
                PageView {
                    ScrollView(showsIndicators: false) {
                        SearchBar(text: $viewModel.searchText, placeholder: L10n.searchCoins)
                            .padding(.horizontal, 16)
                        VStack(spacing: 20) {
                            HoldingsTotalBalanceView(total: viewModel.totalBalance, assetsCount: viewModel.assetsCount)
                            if viewModel.isEmptyAssetsFilteringResults {
                                HoldingsEmptySearchResultsView {
                                    viewModel.clearSearchText()
                                }
                            }
                            AllAssetsView(assets: viewModel.filteredAssets)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                } title: {
                    TitleView {
                        Text(L10n.holdings)
                    } right: {
                        Button("Add asset", systemImage: "plus") {  // TODO: Add loc
                            showAddCoin = true
                        }
                        .foregroundStyle(.accent)
                    }
                }
            }
        }
        .sheet(isPresented: $showAddCoin) {
            AddCoinView(viewModel: appContainer.makeAddCoinViewModel())
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
