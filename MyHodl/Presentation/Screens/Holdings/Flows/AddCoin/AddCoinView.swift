//
//  AddCoinView.swift
//  MyHodl
//
//  Created by DarkSatyr on 26.11.2025.
//

import SwiftUI

struct AddCoinView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: AddCoinViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @StateObject private var viewModel: AddCoinViewModel
    
    var body: some View {
        NavigationStack {
            BackgroundSurface()
                .navigationTitle("Add asset") // TODO: Add loc
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { // TODO: Add loc
                            dismiss()
                        }
                        .foregroundStyle(themeManager.currentTheme.text)
                    }
                }
        }
        
        
    }
}

#Preview {
    AddCoinView(viewModel: AppContainer().makeAddCoinViewModel())
}
