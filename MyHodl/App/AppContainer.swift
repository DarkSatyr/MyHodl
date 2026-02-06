//
//  AppContainer.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.12.2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

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
    
    func makeDashboardViewModel() -> DashboardViewModel {
        container.resolve(DashboardViewModel.self)!
    }
    
    func makeHoldingsViewModel() -> HoldingsViewModel {
        container.resolve(HoldingsViewModel.self)!
    }
    
    func makeEditCoinViewModel(asset: AssetID?) -> EditCoinViewModel {
        container.resolve(EditCoinViewModel.self, argument: asset)!
    }
    
    // Private
    
    private func registerRepositories() {
        container.autoregister(CryptoAssetsInfoRepository.self, initializer: BundleCryptoAssetsInfoRepository.init)
            .inObjectScope(.container)
    }
    
    private func registerUseCases() {
        container.autoregister(FetchCryptoAssetsInfoUseCase.self, initializer: FetchCryptoAssetsInfoUseCase.init)
    }
    
    private func registerViewModels() {
        container.autoregister(AddCoinViewModel.self, initializer: AddCoinViewModel.init)
        container.autoregister(EditCoinViewModel.self, argument: Optional<AssetID>.self, initializer: EditCoinViewModel.init)
        container.autoregister(DashboardViewModel.self, initializer: DashboardViewModel.init)
        container.autoregister(HoldingsViewModel.self, initializer: HoldingsViewModel.init)
    }
    
    private func registerServices() {
        container.autoregister(CryptoAssetsFileLoader.self, initializer: CryptoAssetsFileLoader.init)
        container.autoregister(ThemeManager.self, initializer: ThemeManager.init)
    }
}
