//
//  ExchangeRatesResponse.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation

struct ExchangeRatesResponse: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}

struct CountryCurrencyInfo {
    let countryName: String
    let currency: String
    let flag: String
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case parseError
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .noData:
            return "No data was received from the server."
        case .parseError:
            return "Failed to parse the received data."
        case .networkError:
            return "Failed to connection"
        }
    }
}

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: APIError
}
