//
//  CurrencyPickerView.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI

struct CurrencyPickerView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel
    
    var body: some View {
        Picker("Select Currency", selection: $viewModel.selectedCurrency) {
            ForEach(viewModel.exchangeRates.keys.sorted(), id: \.self) { currency in
                CurrencyInfoView(currencyCode: currency)
                    .tag(currency)
            }
        }
        .pickerStyle(DefaultPickerStyle())
        .frame(minWidth: 300)
        .border(Color.gray, width: 1)
        .padding()
    }
}
