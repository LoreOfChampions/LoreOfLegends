//
//  ChampionDetailData.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 16/04/2024.
//

import Foundation

struct ChampionDetailData: Codable {
    let type: String
    let format: String
    let version: String
    let data: [String: ChampionDetail]
}
