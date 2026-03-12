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
    private let router: AssetEditingRouter

    init(viewModel: AssetSelectViewModel, router: AssetEditingRouter) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.router = router
    }
    
    @StateObject private var viewModel: AssetSelectViewModel
    
    var body: some View {
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
                                .font(themeManager.currentTheme.sectionHeaderFont)
                        }
                        Spacer()
                        ChevronView()
                    }
                    .padding(.leading)
                    .padding(.trailing, 20)
                    .contentShape(Rectangle())
                    .onTapGesture { [weak router] in
                        router?.push(destination: .assetSelected(asset.assetID))
                    }
                }
            }

            BaseButton(title: "Custom Token", type: .normal, action: { [weak router] in
                router?.push(destination: .assetSelected(nil))
            })
            .padding(.horizontal, 16)
            .padding(.top, 10)

        }
        .navigationTitle("Select asset to Add") // TODO: Add loc
        .toolbarTitleDisplayMode(.inline)
        .background(BackgroundSurface().ignoresSafeArea())
    }
}

#Preview {
    AssetSelectView(viewModel: AppContainer().makeAssetSelectViewModel(), router: AssetEditingRouter {})
        .environment(ThemeManager())
        .environment(AppContainer())
}
