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
        let observe = container.resolve(AssetsUseCases.Observe.self)!
        return container.resolve(DashboardViewModel.self, argument: observe)!
    }
    
    func makeHoldingsViewModel() -> HoldingsViewModel {
        let observe = container.resolve(AssetsUseCases.Observe.self)!
        let delete = container.resolve(AssetsUseCases.Delete.self)!
        return container.resolve(HoldingsViewModel.self, arguments: observe, delete)!
    }
    
    func makeAssetEditorViewModel(mode: AssetEditorMode) -> AssetEditorViewModel {
        let get = container.resolve(AssetsUseCases.GetAssetByCode.self)!
        let upsert = container.resolve(AssetsUseCases.UpsertAsset.self)!
        return container.resolve(AssetEditorViewModel.self, arguments: mode, get, upsert)!
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
        container.autoregister(AssetEditorViewModel.self,
                               arguments: AssetEditorMode.self, AssetsUseCases.GetAssetByCode.self, AssetsUseCases.UpsertAsset.self,
                               initializer: AssetEditorViewModel.init)
        container.autoregister(DashboardViewModel.self,
                               argument: AssetsUseCases.Observe.self,
                               initializer: DashboardViewModel.init)
        .inObjectScope(.container)
        
        container.autoregister(HoldingsViewModel.self,
                               arguments: AssetsUseCases.Observe.self, AssetsUseCases.Delete.self,
                               initializer: HoldingsViewModel.init)
        .inObjectScope(.container)
    }
    
    private func registerServices() {
        container.autoregister(CryptoAssetsFileLoader.self, initializer: CryptoAssetsFileLoader.init)
        container.autoregister(ThemeManager.self, initializer: ThemeManager.init)
    }
}
