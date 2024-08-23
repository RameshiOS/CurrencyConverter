//
//  CurrencyAPIService.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation

protocol CurrencyAPIServiceProtocol {
    func fetchExchangeRates(completion: @escaping (Result<[String: Double], APIError>) -> Void)
}

final class CurrencyAPIService: CurrencyAPIServiceProtocol {
    private let baseURL: String
    private let appID = "2eced97dcaf549b78a948a23159d2a7d"
    private let urlSession: URLSession
    
    init(baseURL: String = CurrencyConstants.baseURLValue, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    func fetchExchangeRates(completion: @escaping (Result<[String: Double], APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)?app_id=\(appID)") else {
            completion(.failure(.invalidURL))
            return
        }
        urlSession.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(.failure(.noData))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
                    completion(.success(response.rates))
                } catch {
                    completion(.failure(.parseError))
                }
            }
        }.resume()
    }
}


protocol PersistenceServiceProtocol {
    func saveExchangeRatesToFile(data: [String: Double])
    func loadExchangeRatesFromFile() -> [String: Double]?
}

final class PersistenceService: PersistenceServiceProtocol {
    
    func saveExchangeRatesToFile(data: [String: Double]) {
        do {
            let fileURL = try getFileURL()
            let data = try JSONEncoder().encode(data)
            try data.write(to: fileURL)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadExchangeRatesFromFile() -> [String: Double]? {
        do {
            let fileURL = try getFileURL()
            print("\(fileURL)")
            let data = try Data(contentsOf: fileURL)
            let exchangeRates = try JSONDecoder().decode([String: Double].self, from: data)
            return exchangeRates
        } catch {
            print("Error loading data: \(error)")
            return nil
        }
    }
    
    private func getFileURL() throws -> URL {
        let fileManager = FileManager.default
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectory.appendingPathComponent(CurrencyConstants.fileName)
    }
}

final class CurrencyConstants {
    static let baseURLValue = "https://openexchangerates.org/api/latest.json"
    static let lastDateKey = "lastFetchDate"
    static let fileName = "exchangeRatesData.json"
    static let cacheExpirationInterval: TimeInterval = 30 * 60 // 30 minutes
}
