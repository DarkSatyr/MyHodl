//
//  EditCoinViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import Foundation
import Combine

// TODO: Add loc
@MainActor
final class EditCoinViewModel: ObservableObject {
    
    @Published var amount = ""
    @Published var price = ""
    @Published var total: Decimal = 0
    @Published var name: String = ""
    @Published var code: String = ""
    @Published var image: ImageSource = .placeholder
    @Published var date: Date = Date()
    @Published var coinNameIsEditable = true
    @Published var amountDecimal: Decimal = 0
    @Published var priceDecimal: Decimal = 0
    @Published var nameAndCodeError = ""
    @Published var showNameAndCodeError = false
    @Published var amountError = ""
    @Published var showAmountError = false
    @Published var showDuplicateAlert = false
    @Published var saveEventID: UUID?
    
    private let getAssetUseCase: AssetsUseCases.GetAssetByCode
    private let upsertAssetUseCase: AssetsUseCases.UpsertAsset
    private var cancellables = Set<AnyCancellable>()
    
    init(asset: AssetID?,
         getAssetUseCase: AssetsUseCases.GetAssetByCode,
         upsertAssetUseCase: AssetsUseCases.UpsertAsset) {
        
        if let asset {
            name = asset.name
            code = asset.code.uppercased()
            coinNameIsEditable = false
        }
        
        self.getAssetUseCase = getAssetUseCase
        self.upsertAssetUseCase = upsertAssetUseCase
        
        $code
            .removeDuplicates()
            .map { code in
                ImageSource.local(name: code)
            }
            .assign(to: &$image)
        
        $amount
            .removeDuplicates()
            .map { Decimal.decimalWithCurrentLocale(string: $0, fallback: 0) }
            .assign(to: &$amountDecimal)
        
        $price
            .removeDuplicates()
            .map { Decimal.decimalWithCurrentLocale(string: $0, fallback: 0) }
            .assign(to: &$priceDecimal)
        
        Publishers.CombineLatest3($amountDecimal, $priceDecimal, $code)
            .map { (amount: Decimal, price: Decimal, code: String) in
                amount * price
            }
            .assign(to: &$total)
    }
    
    func save(confirmDuplicate: Bool = false) {
        guard validate() else { return }
        do {
            if !confirmDuplicate, try getAssetUseCase(code) != nil {
                showDuplicateAlert = true
                return
            }
            let asset = Asset(code: code,
                              fullName: name,
                              amount: amountDecimal,
                              startingPrice: priceDecimal,
                              currentPrice: priceDecimal)
            try upsertAssetUseCase(asset)
            saveEventID = UUID()
        } catch {
            print("Asset storage failed")
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
        
        if amountDecimal <= 0 {
            amountError = "Quantity must be greater than 0"
            showAmountError = true
        }
        return !showNameAndCodeError && !showAmountError
    }
}
