//
//  AmountCurrencyEntryView.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI

struct AmountCurrencyEntryView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel
    
    var body: some View {
        VStack {
            HStack {
                AmountCurrencyTextField(amount: $viewModel.desiredAmount, viewModel: viewModel)
                ToggleViewButton(isGridView: $viewModel.isGridView)
            }
            CurrencyPickerView(viewModel: viewModel)

        }
        .onAppear {
            if viewModel.selectedCurrency.isEmpty, let firstCurrency = viewModel.exchangeRates.keys.sorted().first {
                viewModel.selectedCurrency = firstCurrency
            }
        }
        .onChange(of: viewModel.selectedCurrency) { newValue in
            print("Selected currency: \(newValue)")
        }
    }
}

// Extension to hide the keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
