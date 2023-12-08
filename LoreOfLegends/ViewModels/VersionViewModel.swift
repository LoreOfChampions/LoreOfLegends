//
//  VersionViewModel.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation

enum VersionViewModel {
    static func fetchLatestVersion() async throws -> String {
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/api/versions.json") else {
            return ""
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let versions = try decoder.decode([String].self, from: data)

        return versions.first ?? ""
    }
}
