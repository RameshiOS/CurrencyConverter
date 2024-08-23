//
//  CurrencyInfoView.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//
import SwiftUI
struct CurrencyInfoView: View {
    let currencyCode: String
    
    var body: some View {
        if let info = getCountryCurrencyInfo(for: currencyCode) {
            VStack(alignment: .leading) {
                // Flag
                Text("\(info.flag) \(info.countryName) \(currencyCode)")
                    .padding()
            }
        }
        
    }
}
struct CurrencyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyInfoView(currencyCode: "INR")
    }
}
