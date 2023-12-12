//
//  ChampionGridView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

struct ChampionGridView: View {
    @EnvironmentObject var viewModel: ChampionViewModel

    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 200))]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.selectedChampion != nil || !viewModel.searchingQuery.isEmpty ? viewModel.filteredChampions : viewModel.alphabeticallySortedChampions) { champion in
                NavigationLink {
                    ChampionDetailView(champion: champion)
                } label: {
                    ChampionGridCell(champion: champion)
                }
            }
        }
        .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    ChampionGridView()
}
