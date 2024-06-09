//
//  ChampionGridView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import Shimmer

struct ChampionGridView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: .infinity))]
    
    let champions: [Champion]
    let selectedLocale: String

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            if viewModel.selectedChampion != nil || !viewModel.searchingQuery.isEmpty {
                SearchedChampionView(selectedLocale: selectedLocale)
            } else {
                AlphabeticallySortedChampionsView(selectedLocale: selectedLocale)
            }
        }
    }
}

#Preview {
    ChampionGridView(champions: [.exampleChampion], selectedLocale: "")
}
