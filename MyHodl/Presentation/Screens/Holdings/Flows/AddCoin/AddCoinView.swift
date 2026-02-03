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
    @Environment(AppContainer.self) private var appContainer

    init(viewModel: AddCoinViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @StateObject private var viewModel: AddCoinViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
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
                        .onTapGesture {
                            viewModel.showAddCoin(asset: asset.assetID)
                        }
                    }
                }
                
                Button {
                    viewModel.showAddCoin(asset: nil)
                } label: {
                    Text("Custom Token") // TODO SI: Add loc
                        .foregroundStyle(themeManager.currentTheme.accent)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(themeManager.currentTheme.buttonBackground)
                        .clipShape(RoundedRectangle(cornerRadius: themeManager.currentTheme.buttonCornerRadius, style: .continuous))
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)

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
            .navigationDestination(for: AddCoinViewModel.Route.self) { route in
                switch route {
                case .assetSelected(let asset):
                    EditCoinView(viewModel: appContainer.makeEditCoinViewModel(asset: asset))
                }
            }
        }
        .background(BackgroundSurface().ignoresSafeArea())
    }
}

#Preview {
    AddCoinView(viewModel: AppContainer().makeAddCoinViewModel())
}
