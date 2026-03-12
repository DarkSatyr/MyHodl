//
//  AssetEditorView.swift
//  MyHodl
//
//  Created by DarkSatyr on 09.12.2025.
//

import SwiftUI
import SwiftData

// TODO: Add loc
struct AssetEditorView: View {
    
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var viewModel: AssetEditorViewModel
    @State private var showDatePicker = false
    @State private var showDeleteAlert = false
    @FocusState private var isFocused: Bool
    @StateObject private var router: AssetEditingRouter
    
    init(viewModel: AssetEditorViewModel,
         router: AssetEditingRouter) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
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
                            .font(themeManager.currentTheme.sectionHeaderFont)
                            .allowsHitTesting(viewModel.assetIdentityIsEditable)
                            .focused($isFocused)
                            
                            TextField("Code", text: Binding {
                                viewModel.code
                            } set: {
                                viewModel.code = $0.uppercased().trimmed()
                            })
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                            .font(themeManager.currentTheme.sectionTextFont)
                            .allowsHitTesting(viewModel.assetIdentityIsEditable)
                            .focused($isFocused)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    FieldErrorRow(text: viewModel.nameAndCodeError,
                                  show: viewModel.showNameAndCodeError)
                    .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Text("Quantity")
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                                .font(themeManager.currentTheme.sectionTextFont)
                            Spacer()
                        }
                        HStack {
                            TextField("",
                                      text: $viewModel.amount,
                                      prompt: initialAmountFormatted())
                            .limitCurrencyDecimals($viewModel.amount, currency: viewModel.code)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(themeManager.currentTheme.text)
                            .font(themeManager.currentTheme.sectionHeaderFont)
                            .focused($isFocused)
                        Text(viewModel.code)
                            .foregroundStyle(themeManager.currentTheme.textSecondary)
                            .font(themeManager.currentTheme.sectionTextFont)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.top)

                    FieldErrorRow(text: viewModel.amountError,
                                  show: viewModel.showAmountError)
                    .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Text("≈")
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                                .font(themeManager.currentTheme.sectionTextFont)
                            Text(optional: AmountFormat.fiatAmountPrefixed(viewModel.total, currency: viewModel.code))
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                                .font(themeManager.currentTheme.sectionTextFont)
                            Spacer()
                        }
                        .padding(.bottom, 6)
                        VStack {
                            HStack {
                                Text("Purchase price (optional)")
                                    .foregroundStyle(themeManager.currentTheme.textSecondary)
                                    .font(themeManager.currentTheme.sectionTextFont)
                                Spacer()
                            }
                            TextField("",
                                      text: $viewModel.price,
                                      prompt: initialAmountFormatted())
                            .limitPriceDecimals($viewModel.price, price: viewModel.price, currency: viewModel.code)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(themeManager.currentTheme.text)
                            .font(themeManager.currentTheme.sectionHeaderFont)
                            .focused($isFocused)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.vertical, 4)
                    
                    FadedSeparator()
                        .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Text("Date")
                                .foregroundStyle(themeManager.currentTheme.textSecondary)
                                .font(themeManager.currentTheme.sectionTextFont)
                            Spacer()
                        }
                        HStack {
                            Text(DateFormat.date(viewModel.date))
                                .foregroundStyle(themeManager.currentTheme.text)
                                .font(themeManager.currentTheme.sectionHeaderFont)
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
                        .padding(.horizontal)
                }
                .padding(.all)
                .padding(.bottom, 10)
                
                VStack(spacing: 12) {
                    BaseButton(title: "Save", type: .normal, action: {
                        viewModel.save()
                    })
                    BaseButton(title: "Delete", type: .destructive, action: {
                        showDeleteAlert = true
                    })
                    .opacity(viewModel.showDeleteButton ? 1 : 0)
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .onChange(of: viewModel.saveEventID, { [weak router] _, _ in router?.close() })
        .onChange(of: viewModel.deleteEventID, { [weak router] _, _ in router?.close() })
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
        .alert(
            viewModel.deleteTitle(), isPresented: $showDeleteAlert
        ) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.delete()
            }
        } message: {
            Text("This action cannot be undone")
        }
        .onTapGesture {
            isFocused = false
        }
        .navigationTitle(viewModel.title) // TODO: Add loc
        .toolbarTitleDisplayMode(.inline)
        .background(BackgroundSurface().ignoresSafeArea())
    }
    
    private func initialAmountFormatted() -> Text {
        Text(CryptoFormat.amountPlaceholder(0, currency: viewModel.code))
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
    }
}

#Preview {
    AssetEditorView(viewModel: AssetEditorViewModel(mode: .create(nil),
                                              getAssetUseCase: AssetsUseCases.GetAssetByCode(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer())),
                                              upsertAssetUseCase: AssetsUseCases.UpsertAsset(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer())),
                                              deleteAssetUseCase: AssetsUseCases.Delete(repo: AssetsRepositoryImpl(modelContainer: try! ModelContainer()))),
                    router: AssetEditingRouter {})
        .environment(ThemeManager())
}
