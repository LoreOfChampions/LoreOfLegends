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

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            if viewModel.selectedChampion != nil || !viewModel.searchingQuery.isEmpty {
                SearchedChampionView()
            } else {
                AlphabeticallySortedChampionsView(champions: champions)
            }
        }
    }
}

#Preview {
    ChampionGridView(champions: [.exampleChampion])
}
