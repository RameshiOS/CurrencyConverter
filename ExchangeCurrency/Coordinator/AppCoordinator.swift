//
//  AppCoordinator.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import Foundation
import SwiftUI

protocol AppCoordinatorProtocol {
    func start() -> AnyView
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    func start() -> AnyView {
        let viewModel = CurrencyConverterViewModel(
            apiService: CurrencyAPIService(),
            persistenceService: PersistenceService()
        )
        return AnyView(ContentView(viewModel: viewModel))
    }
}
