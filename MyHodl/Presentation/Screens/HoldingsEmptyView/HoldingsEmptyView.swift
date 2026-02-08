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
                Spacer()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("No assets yet")
                            .foregroundStyle(themeManager.currentTheme.text)
                            .font(themeManager.currentTheme.highlightedFont)
                        Text("Add an asset to see it here")
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
                Spacer()
            }
            .frame(maxWidth: .infinity)
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
