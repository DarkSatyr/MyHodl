//
//  AssetEditorViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import Foundation
import Combine

enum AssetEditorMode {
    case create(AssetID?)
    case edit(DashboardAsset)
}

// TODO: Add loc
@MainActor
final class AssetEditorViewModel: ObservableObject {
    
    @Published var amount = ""
    @Published var price = ""
    @Published var total: Decimal?
    @Published var name: String = ""
    @Published var code: String = ""
    @Published var image: ImageSource = .placeholder
    @Published var date: Date = Date()
    @Published var assetIdentityIsEditable = true
    @Published var amountDecimal: Decimal?
    @Published var priceDecimal: Decimal?
    @Published var nameAndCodeError = ""
    @Published var showNameAndCodeError = false
    @Published var amountError = ""
    @Published var showAmountError = false
    @Published var showDuplicateAlert = false
    @Published var saveEventID: UUID?
    @Published var deleteEventID: UUID?
    @Published var title: String = ""
    @Published var showDeleteButton = false
    
    private let getAssetUseCase: AssetsUseCases.GetAssetByCode
    private let upsertAssetUseCase: AssetsUseCases.UpsertAsset
    private let deleteAssetUseCase: AssetsUseCases.Delete
    private var cancellables = Set<AnyCancellable>()
    private let mode: AssetEditorMode
    
    init(mode: AssetEditorMode,
         getAssetUseCase: AssetsUseCases.GetAssetByCode,
         upsertAssetUseCase: AssetsUseCases.UpsertAsset,
         deleteAssetUseCase: AssetsUseCases.Delete) {
        
        self.mode = mode
        self.getAssetUseCase = getAssetUseCase
        self.upsertAssetUseCase = upsertAssetUseCase
        self.deleteAssetUseCase = deleteAssetUseCase
        setup()
        subscribe()
    }
    
    func save(confirmDuplicate: Bool = false) {
        guard validate() else { return }
        do {
            guard let amount = amountDecimal else { return }
            if !confirmDuplicate, try getAssetUseCase(code) != nil, case .create(_) = mode {
                showDuplicateAlert = true
                return
            }
            let asset = Asset(code: code,
                              fullName: name,
                              amount: amount,
                              startingPrice: priceDecimal,
                              currentPrice: priceDecimal)
            try upsertAssetUseCase(asset, policy: policy())
            saveEventID = UUID()
        } catch {
            print("Asset storage failed")
        }
    }
    
    private func policy() -> AssetsUseCases.UpsertAsset.UpsertPolicy {
        switch mode {
        case .create:
            return .createOrMergeByCode
        case .edit:
            return .updateExistingOnly
        }
    }
    
    func deleteTitle() -> String {
        switch mode {
        case .create(let assetID):
            return assetID?.name ?? ""
        case .edit(let asset):
            return "Delete" + " " + asset.fullName.capitalized + "?"
        }
    }
    
    func delete() {
        do {
            if case .edit(let asset) = mode {
                try deleteAssetUseCase(asset.id)
                deleteEventID = UUID()
            }
        } catch {
            print("___Assets delete failed")
        }
    }
    
    private func subscribe() {
        $code
            .removeDuplicates()
            .map { code in
                ImageSource.local(name: code)
            }
            .assign(to: &$image)
        
        $amount
            .removeDuplicates()
            .map(Decimal.decimalWithCurrentLocale)
            .assign(to: &$amountDecimal)
        
        $price
            .removeDuplicates()
            .map(Decimal.decimalWithCurrentLocale)
            .assign(to: &$priceDecimal)
        
        Publishers.CombineLatest3($amountDecimal, $priceDecimal, $code)
            .map { (amount: Decimal?, price: Decimal?, code: String) in
                guard let amount, let price else { return 0 }
                return amount * price
            }
            .assign(to: &$total)
        
        $amountDecimal
            .map { $0 ?? 0 > 0 }
            .removeDuplicates()
            .sink { [weak self] isValid in
                if isValid {
                    self?.showAmountError = false
                }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($name, $code)
            .sink { [weak self] (name, code) in
                guard let self else { return }
                if !name.isEmpty && !code.isEmpty {
                    showNameAndCodeError = false
                }
            }
            .store(in: &cancellables)
    }
    
    private func setup() {
        switch mode {
        case .create(let assetID):
            if let assetID {
                name = assetID.name
                code = assetID.code.normalize()
                assetIdentityIsEditable = false
            }
            title = "Add asset"
        case .edit(let asset):
            name = asset.fullName
            code = asset.code
            amountDecimal = asset.amount
            amount = CryptoFormat.amount(asset.amount, currency: code) ?? ""
            priceDecimal = asset.currentPrice
            price = PriceFormat.fiatPrice(priceDecimal, currency: FiatSymbol.usd) ?? ""
            assetIdentityIsEditable = false
            title = "Edit asset"
            showDeleteButton = true
        }
    }
    
    private func validate() -> Bool {
        showAmountError = false
        showNameAndCodeError = false
        
        if name.isEmpty && code.isEmpty {
            nameAndCodeError = "Name and Code are required"
            showNameAndCodeError = true
        } else if name.isEmpty {
            nameAndCodeError = "Name is required"
            showNameAndCodeError = true
        } else if code.isEmpty {
            nameAndCodeError = "Code is required"
            showNameAndCodeError = true
        }
        
        guard let amount = amountDecimal, amount > 0 else {
            amountError = "Quantity must be greater than zero"
            showAmountError = true
            return false
        }
        return !showNameAndCodeError && !showAmountError
    }
}
