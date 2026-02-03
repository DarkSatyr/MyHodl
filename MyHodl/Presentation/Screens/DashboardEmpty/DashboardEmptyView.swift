//
//  DashboardEmptyView.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.02.2026.
//

import SwiftUI
// TODO: Add loc
struct DashboardEmptyView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @Environment(AppContainer.self) private var appContainer
    @State private var showAddCoin = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(.dashboardEmptyLogo)
                .resizable()
                .scaledToFit()
            VStack(spacing: 10) {
                Text("Start your crypto portfolio")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(themeManager.currentTheme.text)
                    .font(themeManager.currentTheme.highlightedFont)
                Text("Add your first asset to track performance, allocations, and long-term growth")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                    .font(themeManager.currentTheme.subtitleFont)
            }
            HStack {
                GradientPillButton(title: "Add your first asset") {
                    showAddCoin = true
                }
            }
            .padding(.horizontal, 50)
            .padding(.top, 20)

            Spacer()
            
            VStack(spacing: 20) {
                GlowSeparator()
                VStack {
                    Text("Your data stays on your devices and never leaves it.")
                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                        .font(themeManager.currentTheme.disclaimerFont)
                    Text("You stay in control")
                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                        .font(themeManager.currentTheme.disclaimerFont)
                }
            }
            .padding(.bottom, 30)
        }
        .sheet(isPresented: $showAddCoin) {
            AddCoinView(viewModel: appContainer.makeAddCoinViewModel())
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    DashboardEmptyView()
        .environment(ThemeManager())
}
