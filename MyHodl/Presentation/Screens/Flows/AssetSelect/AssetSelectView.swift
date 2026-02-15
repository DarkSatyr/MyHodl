//
//  AssetSelectView.swift
//  MyHodl
//
//  Created by DarkSatyr on 26.11.2025.
//

import SwiftUI

struct AssetSelectView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.dismiss) private var dismiss
    @Environment(AppContainer.self) private var appContainer

    init(viewModel: AssetSelectViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @StateObject private var viewModel: AssetSelectViewModel
    
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
                            ChevronView()
                        }
                        .padding(.leading)
                        .padding(.trailing, 20)
                        .onTapGesture {
                            viewModel.showAddCoin(asset: asset.assetID)
                        }
                    }
                }
                
                BaseButton(title: "Custom Token", type: .normal, action: {
                    viewModel.showAddCoin(asset: nil)
                })
                .padding(.horizontal, 16)
                .padding(.top, 10)

            }
            .navigationTitle("Select asset to Add") // TODO: Add loc
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { // TODO: Add loc
                        dismiss()
                    }
                    .foregroundStyle(themeManager.currentTheme.text)
                }
            }
            .navigationDestination(for: AssetSelectViewModel.Route.self) { route in
                switch route {
                case .assetSelected(let asset):
                    AssetEditorView(viewModel: appContainer.makeAssetEditorViewModel(mode: .create(asset)), onSave: {
                        dismiss()
                    })
                }
            }
        }
        .background(BackgroundSurface().ignoresSafeArea())
    }
}

#Preview {
    AssetSelectView(viewModel: AppContainer().makeAssetSelectViewModel())
        .environment(ThemeManager())
        .environment(AppContainer())
}
