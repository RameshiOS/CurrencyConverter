//
//  AmountCurrencyTextField.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI

struct AmountCurrencyTextField: View {
    @Binding var amount: String
    let viewModel: any CurrencyConverterViewModelProtocol

    var body: some View {
        TextField("Enter Amount", text: $amount)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .keyboardType(.decimalPad)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
            .onChange(of: amount) { newValue in
                self.amount = viewModel.filterAmountInput(newValue)
            }
    }
}
