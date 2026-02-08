//
//  EditCoinView.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import SwiftUI
import SwiftData

// TODO: Add loc
struct EditCoinView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var viewModel: EditCoinViewModel
    @State private var showDatePicker = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var onSave: () -> ()
    
    init(viewModel: EditCoinViewModel, onSave: @escaping () -> ()) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSave = onSave
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 10) {
                        IconView(source: viewModel.image)
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading) {
                            TextField("Name", text: Binding {
                                viewModel.name
                            } set: {
                                viewModel.name = $0.trimmed()
                            })
                            .autocorrectionDisabled(true)
                            .foregroundStyle(themeManager.currentTheme.text)
                            .allowsHitTesting(viewModel.coinNameIsEditable)
                            .focused($isFocused)
                            
                            TextField("Code", text: Binding {
                                viewModel.code
                            } set: {
                                viewModel.code = $0.uppercased().trimmed()
                            })
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                            .allowsHitTesting(viewModel.coinNameIsEditable)
                            .focused($isFocused)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    FieldErrorRow(text: viewModel.nameAndCodeError,
                                  show: viewModel.showNameAndCodeError)
                    
                    HStack {
                        VStack {
                            HStack {
                                Text("Quantity")
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                                Spacer()
                            }
                            HStack {
                                TextField("",
                                          text: $viewModel.amount,
                                          prompt: initialAmountFormatted())
                                    .keyboardType(.decimalPad)
                                    .foregroundStyle(themeManager.currentTheme.text)
                                    .focused($isFocused)
                                Spacer()
                                Text(viewModel.code.uppercased())
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal)

                    FieldErrorRow(text: viewModel.amountError,
                                  show: viewModel.showAmountError)
                    
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
                            TextField("",
                                      text: $viewModel.price,
                                      prompt: initialAmountFormatted())
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
                .padding(.bottom, 10)
                
                BaseButton(title: "Save", action: {
                    viewModel.save()
                })
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .onChange(of: viewModel.saveEventID, { _, _ in onSave() })
        .sheet(isPresented: $showDatePicker) {
            NavigationStack {
                CalendarView(title: "Select date",
                             selectedDate: $viewModel.date, datesRange: ...Date())
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
        .alert("Актив вже додано", isPresented: $viewModel.showDuplicateAlert, actions: {
            Button("Add", role: .confirm) {
                viewModel.save(confirmDuplicate: true)
            }
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("Цей актив уже є у вашому портфелі. Додати кількість до існуючої позиції?")
        })
        .onTapGesture {
            isFocused = false
        }
        .navigationTitle("Add asset") // TODO: Add loc
        .toolbarTitleDisplayMode(.inline)
        .background(BackgroundSurface().ignoresSafeArea())
    }
    
    private func initialAmountFormatted() -> Text {
        Text(Decimal.decimalWithCurrentLocale(string: "0.0", fallback: 0).stringValue)
    }
}

struct FieldErrorRow: View {
    let text: String
    let show: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .font(.caption)
                .foregroundStyle(.red)
                .opacity(show ? 1 : 0)
                .padding(.bottom, 6)
            if show { ErrorSeparator() }
            else { FadedSeparator() }
        }
        .padding(.horizontal)
    }
}

#Preview {
    EditCoinView(viewModel: EditCoinViewModel(asset: nil,
                                              getAssetUseCase: AssetsUseCases.GetAssetByCode(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer())),
                                              upsertAssetUseCase: AssetsUseCases.UpsertAsset(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer()))), onSave: {})
        .environment(ThemeManager())
}
