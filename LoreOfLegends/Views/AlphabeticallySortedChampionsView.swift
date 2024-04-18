//
//  AlphabeticallySortedChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 19/12/2023.
//

import SwiftUI

struct AlphabeticallySortedChampionsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    let champions: [Champion]

    var body: some View {
        ForEach(Array(champions.enumerated()), id: \.offset) { (index, champion) in
            NavigationLink {
                ChampionDetailView(champion: champion)
            } label: {
                ChampionGridCell(champion: champion)
            }
            .onAppear {
                if index == champions.lastIndex(of: champion) {
                    viewModel.currentPage += 1
                }
            }
        }
    }
}

#Preview {
    AlphabeticallySortedChampionsView(champions: [.exampleChampion])
}
