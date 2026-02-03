//
//  DashboardView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel
    @Environment(AppContainer.self) private var appContainer
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var dayChangeTracker = DayChangeTracker()
    
    init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.isEmpty {
            DashboardEmptyView()
        } else {
            PageView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        BalanceView(total: viewModel.totalBalance,
                                    changePercent: viewModel.totalBalanceChange)
                        if let assetAllocation = viewModel.assetAllocation {
                            AssetAllocationView(assetAllocation: assetAllocation)
                        }
                        TopAssetsView(assets: viewModel.assets)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                }
            } title: {
                TitleView {
                    Text(L10n.dashboard)
                } right: {
                    Text(dayChangeTracker.currentDay.formatted(date: .abbreviated,
                                                               time: .omitted))
                }
            }
            .onAppear {
                dayChangeTracker.start()
            }
        }
    }
}

#Preview {
    DashboardView(viewModel: AppContainer().makeDashboardViewModel())
        .environment(ThemeManager())
}
