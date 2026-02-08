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
    
    func makeAddCoinViewModel() -> AddCoinViewModel {
        container.resolve(AddCoinViewModel.self)!
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        let observe = container.resolve(AssetsUseCases.Observe.self)!
        return container.resolve(DashboardViewModel.self, argument: observe)!
    }
    
    func makeHoldingsViewModel() -> HoldingsViewModel {
        let observe = container.resolve(AssetsUseCases.Observe.self)!
        return container.resolve(HoldingsViewModel.self, argument: observe)!
    }
    
    func makeEditCoinViewModel(asset: AssetID?) -> EditCoinViewModel {
        let get = container.resolve(AssetsUseCases.GetAssetByCode.self)!
        let upsert = container.resolve(AssetsUseCases.UpsertAsset.self)!
        return container.resolve(EditCoinViewModel.self, arguments: asset, get, upsert)!
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
    }
    
    private func registerViewModels() {
        container.autoregister(AddCoinViewModel.self, initializer: AddCoinViewModel.init)
        container.autoregister(EditCoinViewModel.self,
                               arguments: Optional<AssetID>.self, AssetsUseCases.GetAssetByCode.self, AssetsUseCases.UpsertAsset.self,
                               initializer: EditCoinViewModel.init)
        container.autoregister(DashboardViewModel.self, argument: AssetsUseCases.Observe.self, initializer: DashboardViewModel.init)
        container.autoregister(HoldingsViewModel.self, argument: AssetsUseCases.Observe.self, initializer: HoldingsViewModel.init)
    }
    
    private func registerServices() {
        container.autoregister(CryptoAssetsFileLoader.self, initializer: CryptoAssetsFileLoader.init)
        container.autoregister(ThemeManager.self, initializer: ThemeManager.init)
    }
}
