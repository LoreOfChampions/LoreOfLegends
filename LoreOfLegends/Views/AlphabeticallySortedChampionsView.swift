//
//  AlphabeticallySortedChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 19/12/2023.
//

import SwiftUI

struct AlphabeticallySortedChampionsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    var body: some View {
        ForEach(Array(viewModel.alphabeticallySortedChampions.enumerated()), id: \.offset) { (index, champion) in
            NavigationLink {
                ChampionDetailView(champion: champion)
            } label: {
                ChampionGridCell(champion: champion)
            }
            .onAppear {
                if index == viewModel.alphabeticallySortedChampions.lastIndex(of: champion) {
                    viewModel.currentPage += 1
                }
            }
        }
    }
}

#Preview {
    AlphabeticallySortedChampionsView()
}
