//
//  ChampionListView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

struct ChampionListView: View {
    @EnvironmentObject var viewModel: ChampionViewModel
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.alphabeticallySortedChampions) { champion in
                NavigationLink {
                    ChampionDetailView(champion: champion)
                } label: {
                    ChampionListCell(champion: champion)
                }
            }
        }
        .tint(Color.gold3)
    }
}

#Preview {
    ChampionListView()
}
