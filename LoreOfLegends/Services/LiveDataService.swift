//
//  LiveDataService.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 12/04/2024.
//

import Foundation

class LiveDataService: DataServiceProtocol {    
    func getChampions() async -> Result<[Champion], DataServiceError> {
        try? await Task.sleep(for: .milliseconds(500))
        
        let endpoint = await Constants.buildURLEndpointString(version: getVersionString())

        guard let url = URL(string: endpoint) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.invalidResponse)
            }

            let decoder = JSONDecoder()
            let championsData = try decoder.decode(ResponseData<Champion>.self, from: data)

            return .success(Array(championsData.data.values))
        } catch {
            return .failure(.invalidData)
        }
    }

    func fetchVersion() async -> Result<String, DataServiceError> {
        guard let url = URL(string: Constants.versionsURL) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            let versions = try decoder.decode([String].self, from: data)

            return .success(versions.first ?? "")
        } catch {
            return .failure(.invalidData)
        }
    }

    func fetchChampionDetails(championID: String) async -> Result<[ChampionDetail], DataServiceError> {
    func fetchLocales() async -> Result<[String], DataServiceError> {
        guard let url = URL(string: Constants.localesURL) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let locales = try decoder.decode([String].self, from: data)
            return .success(locales)
        } catch {
            return .failure(.invalidData)
        }
    }
        try? await Task.sleep(for: .milliseconds(500))
        
        let endpoint = await Constants.buildURLEndpointString(version: getVersionString(), championID: "/" + championID)

        guard let url = URL(string: endpoint) else {
            return .failure(.invalidURL)
        }

        let urlRequest = URLRequest(url: url, timeoutInterval: 5)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.invalidResponse)
            }

            let decoder = JSONDecoder()
            let championDetails = try decoder.decode(ResponseData<ChampionDetail>.self, from: data)

            return .success(Array(championDetails.data.values))
        } catch {
            return .failure(.invalidData)
        }
    }

    // MARK: - Helper Methods

    private func getVersionString() async -> String {
        let result = await fetchVersion()

        switch result {
        case .success(let version):
            return version
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
