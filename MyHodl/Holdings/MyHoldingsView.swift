//
//  MyHoldingsView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

struct MyHoldingsView: View {
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var viewModel = MyHoldingsViewModel()
    
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
                Button("Add Coin", systemImage: "plus") {} // TODO: Add loc
            }
        }
    }
}

#Preview {
    MyHoldingsView()
        .environment(ThemeManager())
}
