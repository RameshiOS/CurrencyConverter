//
//  CurrencyConversionListView.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI
struct CurrencyConversionListView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel

    var body: some View {
        List(viewModel.exchangeRates.keys.sorted(), id: \.self) { currency in
            CurrencyListItemView(currency: currency, viewModel: viewModel)
        }
        .padding(.top, 20)
    }
}

struct CurrencyListItemView: View {
    let currency: String
    @ObservedObject var viewModel: CurrencyConverterViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(convertedAmount(for: currency), specifier: "%.2f") \(currency)")
                .font(.headline)
                .foregroundColor(.blue)
            CurrencyInfoListView(currencyCode: currency)
        }
        .padding()
    }
    
    private func convertedAmount(for currency: String) -> Double {
        guard let amount = Double(viewModel.desiredAmount) else { return 0.0 }
        return viewModel.convertAmount(amount, fromCurrency: viewModel.selectedCurrency, toCurrency: currency)
    }
}
