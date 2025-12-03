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
    @StateObject private var viewModel = HoldingsViewModel()
    @State private var showAddCoin = false
    
    var body: some View {
        PageView {
            ScrollView(showsIndicators: false) {
                SearchBar(text: $viewModel.searchText, placeholder: L10n.searchCoins)
                    .padding(.horizontal, 16)
                VStack(spacing: 20) {
                    BalanceView(total: viewModel.totalBalance,
                                changePercent: viewModel.totalBalanceChange)
                    AllAssetsView(assets: viewModel.filteredAssets)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
        } title: {
            TitleView {
                Text(L10n.myHoldings)
            } right: {
                Button("Add Coin", systemImage: "plus") {  // TODO: Add loc
                    showAddCoin = true
                }
            }
        }
        .sheet(isPresented: $showAddCoin) {
            AddCoinView(viewModel: appContainer.makeAddCoinViewModel())
        }
    }
}

#Preview {
    HoldingsView()
        .environment(ThemeManager())
}
