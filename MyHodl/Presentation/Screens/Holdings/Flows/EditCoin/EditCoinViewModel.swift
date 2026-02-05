//
//  EditCoinViewModel.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import Foundation
import Combine

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
    
    private var cancellables = Set<AnyCancellable>()
    
    init(asset: AssetID?) {
        if let asset {
            name = asset.name
            code = asset.code.uppercased()
            coinNameIsEditable = false
        }
        
        $code
            .removeDuplicates()
            .map { code in
                ImageSource.local(name: code)
            }
            .receive(on: RunLoop.main)
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
        
        $amountDecimal
            .sink { amount in
                print("___AMOUNT: \(amount)")
            }
            .store(in: &cancellables)
    }
}
