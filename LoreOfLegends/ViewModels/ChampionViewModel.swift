//
//  ChampionViewModel.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation

class ChampionViewModel: ObservableObject {
    @Published var champions: [Champion] = []
    @Published var shouldShowGridLayout = false

    var layoutButton: String {
        if shouldShowGridLayout {
            return "square.grid.3x3"
        } else {
            return "list.bullet"
        }
    }

    var alphabeticallySortedChampions: [Champion] {
        return champions.sorted(by: { $0.id < $1.id })
    }

    let version: String

    init(version: String) {
        self.version = version
    }

    // MARK: - Get all the champions with the latest version
    @MainActor func getChampions() async throws {
        let endpoint = Constants.buildURLEndpointString(version: self.version)

        guard let url = URL(string: endpoint) else {
            throw "Invalid URL"
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw "Unable to complete the response"
        }

        let decoder = JSONDecoder()
        let championsData = try decoder.decode(ChampionData.self, from: data)

        self.champions = Array(championsData.data.values)
    }
}