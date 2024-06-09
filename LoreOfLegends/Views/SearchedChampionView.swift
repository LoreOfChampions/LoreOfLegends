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
    let selectedLocale: String

    var body: some View {
        ForEach(viewModel.filteredChampions) { champion in
            NavigationLink {
                ChampionDetailView(champion: champion, selectedLocale: selectedLocale)
            } label: {
                ChampionGridCell(champion: champion)
            }
        }
    }
}

#Preview {
    SearchedChampionView(selectedLocale: "")
}
