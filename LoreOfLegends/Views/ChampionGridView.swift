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
        LazyVGrid(columns: columns) {
            ForEach(viewModel.alphabeticallySortedChampions) { champion in
                NavigationLink {
                    ChampionDetailView(champion: champion)
                } label: {
                    ChampionGridCell(champion: champion)
                }
            }
        }
    }
}

#Preview {
    ChampionGridView()
}
