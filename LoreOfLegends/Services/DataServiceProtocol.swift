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
    func fetchLocales() async -> Result<[String], DataServiceError>
    func fetchChampionDetails(championID: String, locale: String) async -> Result<[ChampionDetail], DataServiceError>
}
