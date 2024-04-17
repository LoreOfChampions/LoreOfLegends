//
//  DataServiceProtocol.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 12/04/2024.
//

import Foundation

protocol DataServiceProtocol {
    func getChampions() async -> Result<[Champion], DataServiceError>
    func fetchVersion() async -> Result<String, DataServiceError>
    func fetchChampionDetails(championID: String) async -> Result<[ChampionDetail], DataServiceError>
}
