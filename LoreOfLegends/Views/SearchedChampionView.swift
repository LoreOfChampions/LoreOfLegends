//
//  SearchedChampionView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 19/12/2023.
//

import SwiftUI

struct SearchedChampionView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    let champion: Champion = Champion.exampleChampion

    var body: some View {
        ForEach(viewModel.filteredChampions) { champion in
            NavigationLink {
                ChampionDetailView(champion: champion)
            } label: {
                ChampionGridCell(champion: champion, isFavorited: viewModel.isFavorited(champion: champion)) {
                    viewModel.toggleFavorite(for: champion)
                }
            }
        }
    }
}

#Preview {
    SearchedChampionView()
}
