ExchangeCurrency App
| Image 1  | image 2 | Image 3  | image 4 | 
| ------------- | ------------- | ------------- | ------------- |
| ![Simulator Screen Shot - iPhone 14 Pro Max - 2024-08-23 at 15 35 31](https://github.com/user-attachments/assets/9ecfdf27-2bf2-4bee-b299-6e6c30c76865) | ![Simulator Screen Shot - iPhone 14 Pro Max - 2024-08-23 at 15 30 27](https://github.com/user-attachments/assets/75023f4e-845d-4910-b46b-d71ed361fcce) | ![Simulator Screen Shot - iPhone 14 Pro Max - 2024-08-23 at 15 28 20](https://github.com/user-attachments/assets/8cff3a2d-f64c-4ef0-a806-e705231a6e1c) | ![Simulator Screen Shot - iPhone 14 Pro Max - 2024-08-23 at 15 28 07](https://github.com/user-attachments/assets/be5de7f8-7724-41d0-92a6-e63a38b155b5) |

This is a currency converter APP based on SwiftUI. It follows the MVVM-Coordinator pattern, which incorporates an API to get immediate currency rates.

## Table of Contents

1. [Introduction](#introduction)
2. [Architecture](#architecture)
   - [Model](#model)
   - [ViewModel](#viewmodel)
   - [View](#view)
   - [Coordinator](#coordinator)
3. [Components](#components)
   - [CurrencyAPIService](#currencyapiservice)
   - [CurrencyConverterViewModel](#currencyconverterviewmodel)
   - [Views](#views)
   - [Coordinator](#coordinator-1)
4. [Testing](#testing)
5. [Installation](#installation)
6. [Usage](#usage)

## Introduction:

The main objective of this application was to create an App that will help users with real time currency conversion information or it can be termed as having a Real-Time Currency Converter. It uses SwiftUI for its user interface.Store offline the data implemnted catch mechanism 

The project is intended to illustrate how to use the MVVM (Model-View-ViewModel) architecture in conjunction with the Coordinator design pattern for navigation and dependency management in ways that encourage scalability.

## Architecture

The app employs the MVVM-Coordinator pattern where data, UI and navigation  are separated.

## Model
 
The “Model” layer represents data and business logic, this includes structures/entities related to currencies in this app

## ViewModel

The `ViewModel` layer acts as a mediator  between the View  and the Model.

## View

The `View` layer consists of SwiftUI views that present  the UI.

## Coordinator

The `Coordinator` pattern is used to manage navigation flow and dependencies. It initializes view models and passes them to the corresponding views. It also handles any navigation or flow control required between different views.

## CurrencyAPIService

`CurrencyAPIService` is responsible for fetching exchange rates from an openexchangerates API.

## CurrencyConverterViewModel
 
 CurrencyConverterViewModel manages the logic for converting currency and interacts with the CurrencyAPIService to fetch rates.

## Views

The views are built using SwiftUI and rely on the CurrencyConverterViewModel.

## Coordinator

The coordinator is responsible for initializing view models and handling navigation

## Testing

The project includes unit tests for the CurrencyAPIService and CurrencyConverterViewModel.

## Installation
To run this project, follow these steps:

Clone the repository

https://github.com/RameshiOS/CurrencyConverter.git

Open the project in Xcode:
- Minumum Xcode version 14
- iOS 13.0+
  
Build and run the project using Xcode.

## Usage
Upon launching the app, the latest exchange rates are fetched from the API.
Enter an amount and select the source and target currencies to see the converted value.
The app dynamically updates the exchange rates and conversion results.
For every 30 minutes it will automatcally call the openexchangerates API fetch the latest rates.

