//
//  HoldingsEmptyView.swift
//  MyHodl
//
//  Created by DarkSatyr on 08.02.2026.
//

import SwiftUI

// TODO: Add loc
struct HoldingsEmptyView: View {
    @Environment(ThemeManager.self) private var themeManager
    @Binding var showAddCoin: Bool
    
    var body: some View {
        PageView {
            VStack {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Image(systemName: "cube.box")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(themeManager.currentTheme.text)
                        Text("Your portfolio is empty")
                            .foregroundStyle(themeManager.currentTheme.text)
                            .font(themeManager.currentTheme.highlightedFont)
                        Text("Add your first asset to start tracking")
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                            .font(themeManager.currentTheme.subtitleFont)
                    }
                    Button {
                        showAddCoin = true
                    } label: {
                        Text("Add asset")
                            .font(.headline)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 28)
                            .frame(minWidth: 180)
                    }
                    .background(.accent.opacity(0.6))
                    .foregroundStyle(.text)
                    .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .offset(y: -40)
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

#Preview {
    HoldingsEmptyView(showAddCoin: Binding(get: {
        false
    }, set: { _ in
        
    }))
    .environment(ThemeManager())
}
