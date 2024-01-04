//
//  SearchedChampionView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 19/12/2023.
//

import SwiftUI

struct SearchedChampionView: View {
    @EnvironmentObject var viewModel: ChampionViewModel
    
    let champion: Champion = Champion.exampleChampion

    var body: some View {
        ForEach(viewModel.filteredChampions) { champion in
            NavigationLink {
                ChampionDetailView(champion: champion)
            } label: {
                ChampionGridCell(champion: champion)
            }
        }
    }
}

#Preview {
    SearchedChampionView()
}
