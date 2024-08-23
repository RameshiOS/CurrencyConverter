//
//  ContentView.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                AmountCurrencyEntryView(viewModel: viewModel)
                
                if viewModel.isGridView {
                    CurrencyConversionGridView(viewModel: viewModel)
                } else {
                    CurrencyConversionListView(viewModel: viewModel)
                }
                Spacer()
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchExchangeRates()
        }
        .alert(item: $viewModel.error) { wrapper in
            Alert(title: Text("Error"), message: Text(wrapper.error.localizedDescription), dismissButton: .default(Text("OK")))
        }
    }
}
