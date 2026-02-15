//
//  AppContainer.swift
//  MyHodl
//
//  Created by DarkSatyr on 03.12.2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import SwiftData

@MainActor
@Observable
final class AppContainer {
    
    private let container = Container()
    private let modelContainer: ModelContainer
    
    private static func createModelContainer() -> ModelContainer {
        do {
            let schema = Schema([
                AssetRecord.self
            ])
            
            let fm = FileManager.default
            let appSupport = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            try fm.createDirectory(at: appSupport, withIntermediateDirectories: true)

            let storeURL = appSupport.appendingPathComponent("default.store")
            
            let config = ModelConfiguration(schema: schema, url: storeURL)
            return try ModelContainer(
                for: schema,
                configurations: [config]
            )
        } catch {
            fatalError("🚨 SwiftData ModelContainer init failed: \(error)")
        }
    }
    
    init() {
        modelContainer = Self.createModelContainer()
        registerServices()
        registerRepositories()
        registerUseCases()
        registerViewModels()
    }
    
    // Factory methods
    
    func makeThemeManager() -> ThemeManager {
        container.resolve(ThemeManager.self)!
    }
    
    func makeAssetSelectViewModel() -> AssetSelectViewModel {
        container.resolve(AssetSelectViewModel.self)!
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        container.resolve(DashboardViewModel.self)!
    }
    
    func makeHoldingsViewModel() -> HoldingsViewModel {
        container.resolve(HoldingsViewModel.self)!
    }
    
    func makeAssetEditorViewModel(mode: AssetEditorMode) -> AssetEditorViewModel {
        container.resolve(AssetEditorViewModel.self, argument: mode)!
    }
    
    // Private
    
    private func registerRepositories() {
        container.autoregister(CryptoAssetsInfoRepository.self, initializer: BundleCryptoAssetsInfoRepository.init)
            .inObjectScope(.container)
        container.register(AssetsRepository.self) { [modelContainer] r in
            AssetsRepositoryImpl(modelContainer: modelContainer)
        }
        .inObjectScope(.container)
    }
    
    private func registerUseCases() {
        container.autoregister(FetchCryptoAssetsInfoUseCase.self, initializer: FetchCryptoAssetsInfoUseCase.init)
        container.autoregister(AssetsUseCases.UpsertAsset.self, initializer: AssetsUseCases.UpsertAsset.init)
        container.autoregister(AssetsUseCases.GetAssetByCode.self, initializer: AssetsUseCases.GetAssetByCode.init)
        container.autoregister(AssetsUseCases.Observe.self, initializer: AssetsUseCases.Observe.init)
        container.autoregister(AssetsUseCases.Delete.self, initializer: AssetsUseCases.Delete.init)
    }
    
    private func registerViewModels() {
        container.autoregister(AssetSelectViewModel.self, initializer: AssetSelectViewModel.init)
        container.register(AssetEditorViewModel.self) { r, mode in
            AssetEditorViewModel(mode: mode,
                                 getAssetUseCase: r~>,
                                 upsertAssetUseCase: r~>,
                                 deleteAssetUseCase: r~>)
        }
        container.register(DashboardViewModel.self) { r in
            DashboardViewModel(assetsObserveUseCase: r~>)
        }
        .inObjectScope(.container)
        
        container.register(HoldingsViewModel.self) { r in
            HoldingsViewModel(assetsObserveUseCase: r~>)
        }
        .inObjectScope(.container)
    }
    
    private func registerServices() {
        container.autoregister(CryptoAssetsFileLoader.self, initializer: CryptoAssetsFileLoader.init)
        container.autoregister(ThemeManager.self, initializer: ThemeManager.init)
    }
}
