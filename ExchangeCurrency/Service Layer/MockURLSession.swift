//
//  MockURLSession.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation
class MockURLSession: URLSession {
    var data: Data?
    var error: Error?
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
