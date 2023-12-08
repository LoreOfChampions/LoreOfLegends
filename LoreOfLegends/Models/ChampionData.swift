//
//  ChampionData.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation

struct ChampionData: Codable {
    let type: String
    let format: String
    let version: String
    let data: [String: Champion]
}
