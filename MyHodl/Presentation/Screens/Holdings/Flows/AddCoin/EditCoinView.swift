//
//  EditCoinView.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import SwiftUI

struct EditCoinView: View {
    
    @StateObject private var viewModel: EditCoinViewModel
    init(viewModel: EditCoinViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
//    EditCoinView()
}
