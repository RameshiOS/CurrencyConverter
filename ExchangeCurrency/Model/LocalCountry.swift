//
//  LocalCountry.swift
//  CurrencyConverter
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation

func getCountryCurrencyInfo(for currencyCode: String) -> CountryCurrencyInfo? {
    // Fetch country information from available locales
    let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
    let locale = locales.first { $0.currency?.identifier == currencyCode }
    
    // Use an English locale for country and currency names
    let englishLocale = Locale(identifier: "en_US")
    
    let countryCode = locale?.language.region?.identifier ?? ""
    let countryName = englishLocale.localizedString(forRegionCode: countryCode) ?? "Unknown Country"
    let currency = englishLocale.localizedString(forCurrencyCode: currencyCode) ?? "Unknown Currency"
    let flag = getFlag(for: countryCode)
    
    if countryName == "Unknown Country" {
        return nil
    }
    
    return CountryCurrencyInfo(countryName: countryName, currency: currency, flag: flag)
}

func getFlag(for countryCode: String) -> String {
    let base = 127397
    var scalarView = String.UnicodeScalarView()
    for i in countryCode.uppercased().unicodeScalars {
        scalarView.append(UnicodeScalar(base + Int(i.value))!)
    }
    return String(scalarView)
}
