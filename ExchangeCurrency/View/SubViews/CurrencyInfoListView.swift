//
//  CurrencyInfoListView.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI

struct CurrencyInfoListView: View {
    let currencyCode: String
    
    var body: some View {
        if let info = getCountryCurrencyInfo(for: currencyCode) {
            VStack(alignment: .leading,spacing: 5) {
                Text("\(info.flag) \(info.countryName)")
                    .padding(5)
                Text("currency Code: \(currencyCode)")
                    .padding(5)
                Text("currency Name: \(info.currency)")
                    .padding(5)
            }
            
        }else {
            Text("currency Code: \(currencyCode)")
        }
        
    }
}
struct CurrencyInfoListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyInfoListView(currencyCode: "INR")
    }
}
