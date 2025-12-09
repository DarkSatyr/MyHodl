//
//  AddCoinView.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import SwiftUI

struct AddCoinView: View {
    
    @StateObject private var viewModel: AddCoinViewModel
    init(viewModel: AddCoinViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
//    AddCoinView()
}
