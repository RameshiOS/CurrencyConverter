//
//  CurrencyConverterViewModel.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation

protocol CurrencyConverterViewModelProtocol: ObservableObject {
    var exchangeRates: [String: Double] { get }
    var error: ErrorWrapper? { get set }
    var isLoading: Bool { get set }
    
    func fetchExchangeRates()
    func convertAmount(_ amount: Double, fromCurrency: String, toCurrency: String) -> Double
    func filterAmountInput(_ input: String) -> String
}

final class CurrencyConverterViewModel: CurrencyConverterViewModelProtocol {
    
    @Published var exchangeRates: [String: Double] = [:]
    @Published var error: ErrorWrapper?
    @Published var isLoading = true
    
    let apiService: CurrencyAPIServiceProtocol
    let persistenceService: PersistenceServiceProtocol
    @Published var currencies: [String] = []
    @Published var selectedCurrency: String = "INR"
    @Published var desiredAmount:String = ""
    @Published var isGridView: Bool = true
    
    init(apiService: CurrencyAPIServiceProtocol, persistenceService: PersistenceServiceProtocol) {
        self.apiService = apiService
        self.persistenceService = persistenceService
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        isLoading = true
        if shouldFetchDataFromCache() {
            loadExchangeRatesFromFile()
            isLoading = false
        } else {
            fetchDataFromAPI()
        }
    }
    
    func convertAmount(_ amount: Double, fromCurrency: String, toCurrency: String) -> Double {
        guard let fromRate = exchangeRates[fromCurrency], let toRate = exchangeRates[toCurrency] else {
            return 0.0
        }
        return (amount / fromRate) * toRate
    }
    
    func filterAmountInput(_ input: String) -> String {
        let filtered = input.filter { "0123456789.".contains($0) }
        let decimalCount = filtered.filter { $0 == "." }.count
        return decimalCount > 1 ? String(filtered.dropLast()) : filtered
    }
    
    func fetchDataFromAPI() {
        apiService.fetchExchangeRates { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rates):
                    self?.exchangeRates = rates
                    self?.persistenceService.saveExchangeRatesToFile(data: rates)
                    UserDefaults.standard.set(Date(), forKey: CurrencyConstants.lastDateKey)
                case .failure(let error):
                    self?.error = ErrorWrapper(error: error)
                }
                self?.isLoading = false
            }
        }
    }
    
    func loadExchangeRatesFromFile() {
        exchangeRates = persistenceService.loadExchangeRatesFromFile() ?? [:]
    }
    
    func shouldFetchDataFromCache() -> Bool {
        guard let lastFetchDate = UserDefaults.standard.object(forKey: CurrencyConstants.lastDateKey) as? Date else {
            return false
        }
        return Date().timeIntervalSince(lastFetchDate) < CurrencyConstants.cacheExpirationInterval
    }
}
