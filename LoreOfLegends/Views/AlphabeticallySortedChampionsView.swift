//
//  AlphabeticallySortedChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 19/12/2023.
//

import SwiftUI

struct AlphabeticallySortedChampionsView: View {
    @EnvironmentObject var viewModel: ChampionViewModel

    let champion: Champion = Champion.exampleChampion

    var body: some View {
        ForEach(Array(viewModel.alphabeticallySortedChampions.enumerated()), id: \.offset) { (index, champion) in
            NavigationLink {
                ChampionDetailView(champion: champion)
            } label: {
                ChampionGridCell(champion: champion)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
