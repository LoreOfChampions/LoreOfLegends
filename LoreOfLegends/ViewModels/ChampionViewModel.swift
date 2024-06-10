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

    let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }

    func load() async {
        await loadLatestVersion()
        await loadLocales()

        let result = await dataService.getChampions()

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

    private func loadLatestVersion() async {
        let result = await dataService.fetchVersion()

        switch result {
        case .success(let version):
            latestVersion = version
        case .failure(let error):
            print(error)
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
