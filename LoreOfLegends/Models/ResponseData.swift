//
//  ResponseData.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 16/04/2024.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
    let type: String
    let format: String
    let version: String
    let data: [String: T]
}
