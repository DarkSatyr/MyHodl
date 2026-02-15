//
//  AssetEditorScreen.swift
//  MyHodl
//
//  Created by DarkSatyr on 13.02.2026.
//

import SwiftUI
import SwiftData

struct AssetEditorScreen: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.dismiss) private var dismiss
    
    let viewModel: AssetEditorViewModel

    var body: some View {
        NavigationStack {
            AssetEditorView(viewModel: viewModel, onSave: {
                dismiss()
            }, onDelete: {
                dismiss()
            })
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
    AssetEditorScreen(viewModel: AssetEditorViewModel(mode: .create(nil),
                                                      getAssetUseCase: AssetsUseCases.GetAssetByCode(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer())),
                                                      upsertAssetUseCase: AssetsUseCases.UpsertAsset(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer())),
                                                      deleteAssetUseCase: AssetsUseCases.Delete(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer()))))
                .environment(ThemeManager())
}
