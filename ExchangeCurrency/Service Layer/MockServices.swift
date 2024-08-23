//
//  MockServices.swift
//  ExchangeCurrencyTests
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation
class MockCurrencyAPIService: CurrencyAPIServiceProtocol {
    var fetchExchangeRatesResult: Result<[String: Double], APIError>?

    func fetchExchangeRates(completion: @escaping (Result<[String: Double], APIError>) -> Void) {
        if let result = fetchExchangeRatesResult {
            completion(result)
        }
    }
}

class MockPersistenceService: PersistenceServiceProtocol {
    var savedData: [String: Double]?
    var loadDataResult: [String: Double]?

    func saveExchangeRatesToFile(data: [String: Double]) {
        savedData = data
    }

    func loadExchangeRatesFromFile() -> [String: Double]? {
        return loadDataResult
    }
}
