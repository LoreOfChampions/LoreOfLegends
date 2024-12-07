//
//  ChampionViewModel.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation
import SwiftUI

@MainActor final class ChampionViewModel: ObservableObject {
    @AppStorage("selectedLocale") var selectedLocale: String = "en_US"
    @AppStorage("FavoriteChampionIDs") private var favoriteChampionIDs: Data = Data()
    
    @Published var champions: [Champion] = []
    @Published var locales: [Locale] = []
    @Published var selectedChampion: Champion?
    @Published var searchingQuery = ""
    @Published var state: State = .loading
    @Published var currentPage = 1
    @Published var latestVersion: String = ""

    enum State {
        case loading
        case loaded([Champion])
        case error(DataServiceError, retry: () async -> Void)
    }
    
    private let pageSize = 20
    
    let dataService: DataServiceProtocol
    
    var favoriteStates: [String:Bool] {
        get {
            favoriteChampionIDsToDictionary()
        }
        set {
            saveFavoriteChampionIDs(newValue)
        }
    }

    var filteredChampions: [Champion] {
        if let champion = selectedChampion {
            return champions.filter({ $0.id.contains(champion.id) })
        } else {
            if !searchingQuery.isEmpty {
                let lowercasedQuery = searchingQuery.lowercased()
                return champions.filter({ $0.name.lowercased().contains(lowercasedQuery) })
            } else {
                return []
            }
        }
    }

    var alphabeticallySortedChampions: [Champion] {
        return Array(champions.sorted(by: { $0.id < $1.id }).prefix(currentPage * pageSize))
    }
    
    var favoritedChampions: [Champion] {
        alphabeticallySortedChampions.filter { isFavorited(champion: $0) }
    }

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }

    func load() async {
        async let loadLocales = loadLocales()
        async let loadLatestVersion = loadLatestVersion()
        async let loadChampionsData = dataService.getChampions()

        let (locales, latestVersion, result) = await (loadLocales, loadLatestVersion, loadChampionsData)

        self.latestVersion = latestVersion
        self.locales = locales

        switch result {
        case .success(let champions):
            self.champions = champions
            state = .loaded(champions)
        case .failure(let error):
            state = .error(error, retry: { [weak self] in
                self?.state = .loading
                await self?.load()
            })
        }
    }
    func isFavorited(champion: Champion) -> Bool {
        return favoriteStates[champion.id] ?? false
    }
    
    func toggleFavorite(for champion: Champion) {
        favoriteStates[champion.id] = !(favoriteStates[champion.id] ?? false)
    }
    
    private func favoriteChampionIDsToDictionary() -> [String: Bool] {
        guard let ids = try? JSONDecoder().decode([String].self, from: favoriteChampionIDs) else {
            return [:]
        }
        return Dictionary(uniqueKeysWithValues: ids.map { ($0, true) })
    }
    
    private func saveFavoriteChampionIDs(_ dictionary: [String: Bool]) {
        let ids = dictionary.filter { $0.value }.map { $0.key }
        if let data = try? JSONEncoder().encode(ids) {
            favoriteChampionIDs = data
        }
    }

    private func loadLatestVersion() async -> String {
        let result = await dataService.fetchVersion()

        switch result {
        case .success(let version):
            return version
        case .failure(let error):
            print(error)
            return ""
        }
    }

    private func loadLocales() async -> [Locale] {
        let result = await dataService.fetchLocales()

        switch result {
        case .success(let locales):
            return locales
        case .failure(let error):
            print(error)
            return []
        }
    }
}
