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
    @State private var isLoadingMoreChampions: Bool = false

    @Binding var isLoading: Bool

    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 200))]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            if viewModel.selectedChampion != nil || !viewModel.searchingQuery.isEmpty {
                ForEach(viewModel.filteredChampions) { champion in
                    NavigationLink {
                        ChampionDetailView(champion: champion)
                    } label: {
                        ChampionGridCell(champion: champion)
                    }
                }
            } else {
                if isLoading {
                    ForEach(0..<10) { _ in
                        SampleCell()
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                } else {
                    ForEach(Array(viewModel.alphabeticallySortedChampions.enumerated()), id: \.offset) { (index, champion) in
                        NavigationLink {
                            ChampionDetailView(champion: champion)
                        } label: {
                            ChampionGridCell(champion: champion)
                        }
                        .onAppear {
                            if index == viewModel.alphabeticallySortedChampions.count - 5 {
                                isLoadingMoreChampions = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    viewModel.currentPage += 1
                                    isLoadingMoreChampions = false
                                }
                            }
                        }
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))

        if isLoadingMoreChampions {
            ProgressView()
                .padding(.top)
                .opacity(0.5)
        }
    }
}

#Preview {
    ChampionGridView(isLoading: .constant(false))
}
