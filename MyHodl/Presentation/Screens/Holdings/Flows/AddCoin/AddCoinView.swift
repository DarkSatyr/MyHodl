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
            ScrollView(showsIndicators: false) {
                SearchBar(text: $viewModel.searchedText, placeholder: "Search Coins") // TODO: Add Loc
                    .padding(.bottom)
                
                HStack {
                    Text(viewModel.searchResult.sectionName)
                        .foregroundStyle(themeManager.currentTheme.text)
                        .font(themeManager.currentTheme.sectionHeaderFont)
                    Spacer()
                }
                .padding(.leading)
                .padding(.bottom)
                
                LazyVStack {
                    ForEach(viewModel.searchResult.assets) { asset in
                        HStack {
                            HStack {
                                IconView(source: asset.icon)
                                    .frame(width: 40, height: 40)
                                Text(asset.name)
                                    .foregroundStyle(themeManager.currentTheme.text)
                                    .font(themeManager.currentTheme.sectionTextFont)
                            }
                            Spacer()
                            IconView(source: .system(symbol: "chevron.forward"))
                                .foregroundStyle(themeManager.currentTheme.accent)
                                .frame(width: 16, height: 16)
                        }
                        .padding(.leading)
                        .padding(.trailing, 20)
                    }
                }
            }
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
        .background(BackgroundSurface().ignoresSafeArea())
    }
}

#Preview {
    AddCoinView(viewModel: AppContainer().makeAddCoinViewModel())
}
