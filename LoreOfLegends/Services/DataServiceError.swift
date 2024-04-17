//
//  DataServiceError.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 12/04/2024.
//

import Foundation

enum DataServiceError: Error, LocalizedError {
    case networkError
    case invalidURL
    case invalidResponse
    case invalidData

    var errorTitle: String {
        return "Oops!"
    }

    var errorDescription: String? {
        return "Looks like you have an internet connection problem. Try again."
    }

    var buttonTitle: String {
        return "Try again"
    }
}
