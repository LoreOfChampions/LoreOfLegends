//
//  ChampionGridView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import Shimmer

struct ChampionGridView: View {
    @EnvironmentObject var viewModel: ChampionViewModel

    @Binding var isLoading: Bool

    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: .infinity))]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            if viewModel.selectedChampion != nil || !viewModel.searchingQuery.isEmpty {
                SearchedChampionView()
            } else {
                if isLoading {
                    ForEach(0..<10) { _ in
                        SampleCell()
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                } else {
                    AlphabeticallySortedChampionsView()
                }
            }
        }
    }
}

#Preview {
    ChampionGridView(isLoading: .constant(false))
}
