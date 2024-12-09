//
//  ChampionDetailViewModel.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation

@MainActor final class ChampionDetailViewModel: ObservableObject {
    @Published private(set) var championDetail: ChampionDetail = .exampleChampionDetail
    @Published private(set) var state: State = .loading

    enum State {
        case loading
        case loaded([ChampionDetail])
        case error(DataServiceError, retry: () async -> Void)
    }

    let dataService: DataServiceProtocol
    
    // MARK: - Init

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Methods

    func loadChampionDetails(championID: String, locale: String) async {
        self.state = .loading
        let result = await dataService.fetchChampionDetails(championID: championID, locale: locale)

        switch result {
        case .success(let championDetails):
            state = .loaded(championDetails)
        case .failure(let error):
            state = .error(error, retry: { [weak self] in
                self?.state = .loading
                await self?.loadChampionDetails(championID: championID, locale: locale)
            })
        }
    }
}
