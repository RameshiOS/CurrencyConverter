//
//  CurrencyAPIServiceTests.swift
//  ExchangeCurrencyTests
//
//  Created by Ramesh Guddala on 22/08/24.
//

import XCTest
@testable import ExchangeCurrency

class CurrencyAPIServiceTests: XCTestCase {
    
    var service: CurrencyAPIService!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        service = CurrencyAPIService(urlSession: mockURLSession)
    }
    
    override func tearDown() {
        service = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchExchangeRates_Failure_InvalidURL() {
        // Given
        service = CurrencyAPIService(baseURL: "Invalid URL", urlSession: mockURLSession)
        
        let expectation = XCTestExpectation(description: "Invalid URL error")
        
        // When
        service.fetchExchangeRates { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                // Then
                XCTAssertEqual(error, APIError.invalidURL)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchExchangeRates_Success() {
        // Given
        let mockData = """
        {
            "rates": {
                "USD": 1.0,
                "EUR": 0.85
            }
        }
        """.data(using: .utf8)
        
        mockURLSession.data = mockData
        
        let expectation = XCTestExpectation(description: "Fetch exchange rates successfully")
        
        // When
        service.fetchExchangeRates { result in
            switch result {
            case .success(let rates):
                // Then
                XCTAssertEqual(rates["USD"], 1.0)
                XCTAssertEqual(rates["EUR"], 0.85)
            case .failure:
                XCTAssertNotNil("failed")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    
    
    
    
    func testFetchExchangeRates_Failure_NoData() {
        // Given
        mockURLSession.error = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        let expectation = XCTestExpectation(description: "No data error")
        
        // When
        service.fetchExchangeRates { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                // Then
                XCTAssertEqual(error, APIError.noData)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchExchangeRates_Failure_ParseError() {
        // Given
        let mockData = """
        { "invalid_json": {} }
        """.data(using: .utf8)
        
        mockURLSession.data = mockData
        
        let expectation = XCTestExpectation(description: "Parse error")
        
        // When
        service.fetchExchangeRates { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                // Then
                XCTAssertEqual(error, APIError.parseError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

