//
//  AppContainer.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.12.2025.
//

import Foundation
import Swinject

@MainActor
@Observable
final class AppContainer {
    
    private let container = Container()
    
    init() {
        registerServices()
        registerRepositories()
        registerUseCases()
        registerViewModels()
    }
    
    // Factory methods
    
    func makeThemeManager() -> ThemeManager {
        container.resolve(ThemeManager.self)!
    }
    
    func makeAddCoinViewModel() -> AddCoinViewModel {
        container.resolve(AddCoinViewModel.self)!
    }
    
    // Private
    
    private func registerRepositories() {
        container.register(AssetRepository.self) { r in
            BundleAssetRepository(loader: r.resolve(AssetFileLoader.self)!)
        }
        .inObjectScope(.container)
    }
    
    private func registerUseCases() {
        container.register(FetchAssetsUseCase.self) { r in
            FetchAssetsUseCase(repository: r.resolve(AssetRepository.self)!)
        }
    }
    
    private func registerViewModels() {
        container.register(AddCoinViewModel.self) { r in
            AddCoinViewModel(fetchAssetsUseCase: r.resolve(FetchAssetsUseCase.self)!)
        }
    }
    
    private func registerServices() {
        container.register(AssetFileLoader.self) { _ in
            AssetFileLoader()
        }
        container.register(ThemeManager.self) { _ in
            ThemeManager()
        }
    }
}
