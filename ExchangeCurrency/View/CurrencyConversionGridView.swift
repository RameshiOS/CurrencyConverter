//
//  CurrencyConversionGridView.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//
import SwiftUI

struct CurrencyConversionGridView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(viewModel.exchangeRates.keys.sorted(), id: \.self) { currency in
                    CurrencyGridItemView(currency: currency, viewModel: viewModel)
                }
            }
        }
        .padding(.top, 20)
    }
}

struct CurrencyGridItemView: View {
    let currency: String
    @ObservedObject var viewModel: CurrencyConverterViewModel
    
    var body: some View {
        VStack {
            if let info = getCountryCurrencyInfo(for: currency) {
                Text(info.flag)
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("\(convertedAmount(for: currency), specifier: "%.2f") \(currency)")
            }else {
                Text("\(convertedAmount(for: currency), specifier: "%.2f") \(currency)")
            }
        }
        .frame(minWidth: 50, idealWidth: 100, maxWidth: 1000, minHeight: 100, idealHeight: 100, maxHeight: 1000, alignment: .center)

       // .frame(minWidth: 50, minHeight: 100)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private func convertedAmount(for currency: String) -> Double {
        guard let amount = Double(viewModel.desiredAmount) else { return 0.0 }
        return viewModel.convertAmount(amount, fromCurrency: viewModel.selectedCurrency, toCurrency: currency)
    }
}
