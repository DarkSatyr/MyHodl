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
    
    func makeSelectCoinViewModel() -> SelectCoinViewModel {
        container.resolve(SelectCoinViewModel.self)!
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        container.resolve(DashboardViewModel.self)!
    }
    
    func makeHoldingsViewModel() -> HoldingsViewModel {
        container.resolve(HoldingsViewModel.self)!
    }
    
    // Private
    
    private func registerRepositories() {
        container.autoregister(AssetRepository.self, initializer: BundleAssetRepository.init)
            .inObjectScope(.container)
    }
    
    private func registerUseCases() {
        container.autoregister(FetchAssetsUseCase.self, initializer: FetchAssetsUseCase.init)
    }
    
    private func registerViewModels() {
        container.autoregister(SelectCoinViewModel.self, initializer: SelectCoinViewModel.init)
        container.autoregister(DashboardViewModel.self, initializer: DashboardViewModel.init)
        container.autoregister(HoldingsViewModel.self, initializer: HoldingsViewModel.init)
    }
    
    private func registerServices() {
        container.autoregister(AssetFileLoader.self, initializer: AssetFileLoader.init)
        container.autoregister(ThemeManager.self, initializer: ThemeManager.init)
    }
}
