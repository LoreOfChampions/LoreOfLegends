//
//  ChampionDetailViewModel.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation

class ChampionDetailViewModel: ObservableObject {
    let version: String

    init(version: String) {
        self.version = version
    }

    //MARK: - Fetch all the extra data related to the specific champion from the latest version
    func fetchChampionDetails(championID: String) async throws -> ChampionData {
        let endpoint = Constants.buildURLEndpointString(version: self.version, championID: "/" + championID)

        guard let url = URL(string: endpoint) else {
            throw LOLError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw LOLError.unableToComplete
        }

        let decoder = JSONDecoder()
        let championDetails = try decoder.decode(ChampionData.self, from: data)

        return championDetails
    }
}
