//
//  DashboardView.swift
//  MyHodl
//
//  Created by DarkSatyr on 11.11.2025.
//

import SwiftUI

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var dayChangeTracker = DayChangeTracker()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    BalanceView()
                    AssetAllocationView()
                    TopHoldingsView(assets: viewModel.assets)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .background(
                DashboardSurface()
                    .ignoresSafeArea()
            )
            .safeAreaInset(edge: .top) {
                TitleView(
                    leftLabel: L10n.dashboard,
                    rightLabel: dayChangeTracker.currentDay.formatted(date: .abbreviated,
                                                                      time: .omitted)
                )
                .fixedSize(horizontal: false, vertical: true)
            }
            .toolbar(.hidden, for: .navigationBar) // свій хедер, системний ховаємо
        }
        .background(themeManager.currentTheme.background)
        .onAppear {
            dayChangeTracker.start()
        }
    }
}

#Preview {
    DashboardView()
        .environment(ThemeManager())
}

struct DashboardSurface: View {
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        RoundedRectangle(cornerRadius: 28, style: .continuous)
            .fill(surfaceColor)
    }
    
    private var surfaceColor: LinearGradient {
        LinearGradient(
            colors: [
                themeManager.currentTheme.accent.opacity(0.10),
                Color.black.opacity(0.85)
            ],
            startPoint: .bottom,
            endPoint: .topLeading
        )
    }
}
