//
//  AssetAllocationView.swift
//  MyHodl
//
//  Created by DarkSatyr on 12.11.2025.
//

import SwiftUI

struct AssetAllocationView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        ZStack(alignment: .leading) {
            DashboardCard()
            VStack(alignment: .leading, spacing: 12) {
                Text(L10n.assetAllocation)
                    .font(themeManager.currentTheme.sectionHeaderFont)
                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                VStack(alignment: .leading, spacing: 8) {
                    Text(L10n.crypto)
                        .font(themeManager.currentTheme.highlightedFont)
                        .foregroundStyle(themeManager.currentTheme.text)
                    Text("75%")
                        .font(themeManager.currentTheme.highlightedFont)
                        .foregroundStyle(themeManager.currentTheme.accent)
                    HStack {
                        HStack {
                            Text(L10n.crypto)
                                .font(themeManager.currentTheme.font)
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                        }
                        HStack {
                            Text(L10n.fiat)
                                .font(themeManager.currentTheme.font)
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                        }
                    }
                }
            }
            .padding(.all)
        }
        
    }
}

#Preview {
    AssetAllocationView()
        .fixedSize(horizontal: false, vertical: true)
        .environment(ThemeManager())
}
