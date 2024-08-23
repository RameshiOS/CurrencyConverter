//
//  ExchangeCurrencyTests.swift
//  ExchangeCurrencyTests
//
//  Created by Ramesh Guddala on 22/08/24.
//

import XCTest
@testable import ExchangeCurrency

class CurrencyConverterViewModelTests: XCTestCase {

    var viewModel: CurrencyConverterViewModel!
    var mockAPIService: MockCurrencyAPIService!
    var mockPersistenceService: MockPersistenceService!
    var mockRates: [String: Double]!

    override func setUp() {
        super.setUp()
        mockAPIService = MockCurrencyAPIService()
        mockPersistenceService = MockPersistenceService()
        viewModel = CurrencyConverterViewModel(apiService: mockAPIService, persistenceService: mockPersistenceService)
        mockRates = loadMockRatesFromJSON()
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        mockPersistenceService = nil
        mockRates = nil
        super.tearDown()
    }

    func testFetchExchangeRates_Success() {
        mockAPIService.fetchExchangeRatesResult = .success(mockRates)

        viewModel.fetchExchangeRates()

        XCTAssertEqual(viewModel.exchangeRates, [:])
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchExchangeRates_Failure() {
        let mockError = APIError.networkError
        mockAPIService.fetchExchangeRatesResult = .failure(mockError)

        viewModel.fetchExchangeRates()

        XCTAssertTrue(viewModel.exchangeRates.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testConvertAmount() {
        viewModel.exchangeRates = mockRates

        let convertedAmount = viewModel.convertAmount(100, fromCurrency: "USD", toCurrency: "EUR")
        XCTAssertEqual(convertedAmount, 90.0041)
    }

    func testFilterAmountInput() {
        let input = "100.50"
        let filteredInput = viewModel.filterAmountInput(input)
        XCTAssertEqual(filteredInput, "100.50")

        let invalidInput = "100.50abc"
        let filteredInvalidInput = viewModel.filterAmountInput(invalidInput)
        XCTAssertEqual(filteredInvalidInput, "100.50")
    }

    func testSaveAndLoadExchangeRates() {
        viewModel.exchangeRates = mockRates

        viewModel.fetchExchangeRates()
        XCTAssertEqual(mockPersistenceService.savedData, nil)

        mockPersistenceService.loadDataResult = mockRates
        let loadedRates = viewModel.persistenceService.loadExchangeRatesFromFile()
        XCTAssertEqual(loadedRates, mockRates)
    }
    
    func loadMockRatesFromJSON() -> [String: Double]? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockData", withExtension: "json") else {
            XCTFail("Failed to locate MockData.json in the test bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let rates = json["rates"] as? [String: Double] {
                return rates
            } else {
                XCTFail("Failed to parse rates from JSON.")
                return nil
            }
        } catch {
            XCTFail("Error reading or parsing MockData.json: \(error)")
            return nil
        }
    }

}
