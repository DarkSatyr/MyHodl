//
//  EditCoinView.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import SwiftUI

// TODO: Add loc
struct EditCoinView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    
    @StateObject private var viewModel: EditCoinViewModel
    init(viewModel: EditCoinViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
//                    RoundedRectangle(cornerRadius: 22)
//                        .fill(.backgroundSecondary)
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            IconView(source: .placeholder)
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading) {
                                Text("Bitcoin")
                                    .foregroundStyle(themeManager.currentTheme.text)
                                Text("BTC")
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.vertical, 4)
                        
                        FadedSeparator()
                        
                        HStack {
                            VStack {
                                HStack {
                                    Text("Quantity")
                                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                                    Spacer()
                                }
                                HStack {
                                    TextField("0.0", text: $viewModel.amount)
                                        .foregroundStyle(themeManager.currentTheme.text)
                                    Spacer()
                                    Text("BTC")
                                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                                }
                            }
                        }
                        .padding()
                        .padding(.vertical, 4)
                        
                        FadedSeparator()
                        
                        VStack {
                            HStack {
                                Text("≈")
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                                Text("$0.0")
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                                Spacer()
                            }
                            .padding(.bottom, 6)
                            VStack {
                                HStack {
                                    Text("Purchase price (optional)")
                                        .foregroundStyle(themeManager.currentTheme.textSecondary)
                                    Spacer()
                                }
                                TextField("0.0", text: $viewModel.amount)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.vertical, 4)
                        
                        FadedSeparator()
                        
                        VStack {
                            HStack {
                                Text("Date")
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                                Spacer()
                            }
                            HStack {
                                Text("May 22, 2023")
                                    .foregroundStyle(themeManager.currentTheme.text)
                                Spacer()
                                ChevronView()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.vertical, 4)
                        
                        Spacer()
                        
                        FadedSeparator()
                    }
                    .padding(.all)
                }
                .padding(.bottom, 10)
                
                
                BaseButton(title: "Save", action: {
                    
                })
                .padding(.horizontal, 16)
                
                Spacer()
            }
            
            
        }
        .navigationTitle("Add asset") // TODO: Add loc
        .toolbarTitleDisplayMode(.inline)
        .background(BackgroundSurface().ignoresSafeArea())
    }
}

#Preview {
    EditCoinView(viewModel: EditCoinViewModel(asset: nil))
        .environment(ThemeManager())
}
