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
    @State private var searchText = ""
    
    var body: some View {
        PageView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    BalanceView(total: viewModel.totalBalance,
                                changePercent: viewModel.totalBalanceChange)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
        } title: {
            TitleView {
                Text(L10n.myHoldings)
            } right: {}
        }
    }
}

#Preview {
    MyHoldingsView()
        .environment(ThemeManager())
}
