//
//  DashboardView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel
    let onViewAllHoldings: () -> Void
    @Environment(AppContainer.self) private var appContainer
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var dayChangeTracker = DayChangeTracker()
    @State private var showAddCoin: Bool = false
    
    init(viewModel: DashboardViewModel, onViewAllHoldings: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onViewAllHoldings = onViewAllHoldings
    }
    
    var body: some View {
        Group {
            if viewModel.isEmpty {
                DashboardEmptyView(showAddCoin: $showAddCoin)
            } else {
                PageView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            BalanceView(total: viewModel.totalBalance,
                                        changePercent: viewModel.totalBalanceChange)
                            if let assetAllocation = viewModel.assetAllocation {
                                AssetAllocationView(assetAllocation: assetAllocation)
                            }
                            TopAssetsView(assets: viewModel.assets) {
                                self.onViewAllHoldings()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 20)
                    }
                } title: {
                    TitleView {
                        Text(L10n.dashboard)
                    } right: {
                        Button("", systemImage: "plus") {  // TODO: Add loc
                            showAddCoin = true
                        }
                        .foregroundStyle(.accent)
                    }
                }
            }
        }
        .sheet(isPresented: $showAddCoin) {
            AssetSelectView(viewModel: appContainer.makeAssetSelectViewModel())
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    DashboardView(viewModel: AppContainer().makeDashboardViewModel()) {
        
    }
    .environment(ThemeManager())
}
