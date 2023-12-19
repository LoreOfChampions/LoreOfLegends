//
//  LOLError.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 19/12/2023.
//

import Foundation

enum LOLError: String, Error {
    case invalidURL = "Invalid URL"
    case unableToComplete = "Unable to complete the response. Please, check your internet"
    case unableToDecodeData = "Unable  to decode the data"
}
