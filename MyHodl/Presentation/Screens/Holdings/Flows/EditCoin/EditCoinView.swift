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
    @State private var showDatePicker = false
    @FocusState private var isFocused: Bool
    
    init(viewModel: EditCoinViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            IconView(source: viewModel.image)
                                .frame(width: 40, height: 40)

                            VStack(alignment: .leading) {
                                TextField("Name", text: Binding {
                                    viewModel.name
                                } set: {
                                    viewModel.name = $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                })
                                .foregroundStyle(themeManager.currentTheme.text)
                                .allowsHitTesting(viewModel.coinNameIsEditable)
                                .focused($isFocused)
                                
                                TextField("Code", text: Binding {
                                    viewModel.code
                                } set: {
                                    viewModel.code = $0.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                })
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                                .allowsHitTesting(viewModel.coinNameIsEditable)
                                .focused($isFocused)
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
                                    TextField(initialAmountFormatted(),
                                              text: $viewModel.amount)
                                        .keyboardType(.decimalPad)
                                        .foregroundStyle(themeManager.currentTheme.text)
                                        .focused($isFocused)
                                    Spacer()
                                    Text(viewModel.code.uppercased())
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
                                Text(FiatSymbol.usd.rawValue + AmountFormat.amount(viewModel.total, currency: viewModel.code))
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
                                TextField(initialAmountFormatted(),
                                          text: $viewModel.price)
                                .keyboardType(.decimalPad)
                                .foregroundStyle(themeManager.currentTheme.text)
                                .focused($isFocused)
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
                                Text(DateFormat.date(viewModel.date))
                                    .foregroundStyle(themeManager.currentTheme.text)
                                Spacer()
                                ChevronView()
                            }
                        }
                        .onTapGesture {
                            showDatePicker = true
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
        .sheet(isPresented: $showDatePicker) {
            NavigationStack {
                CalendarView(selectedDate: $viewModel.date, datesRange: ...Date())
                    .navigationTitle("Select date")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showDatePicker = false
                            }
                            .foregroundStyle(.text)
                        }
                    }
            }
            .presentationDetents([.medium])
        }
        .onTapGesture {
            isFocused = false
        }
        .navigationTitle("Add asset") // TODO: Add loc
        .toolbarTitleDisplayMode(.inline)
        .background(BackgroundSurface().ignoresSafeArea())
    }
    
    private func initialAmountFormatted() -> String {
        Decimal.decimalWithCurrentLocale(string: "0.0", fallback: 0).stringValue
    }
}

#Preview {
    EditCoinView(viewModel: EditCoinViewModel(asset: nil))
        .environment(ThemeManager())
}


struct CalendarView: View {
    @Binding var selectedDate: Date
    let datesRange: PartialRangeThrough<Date>
    
    var body: some View {
        DatePicker(
            "Select date",
            selection: $selectedDate,
            in: datesRange,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .padding()
    }
}
