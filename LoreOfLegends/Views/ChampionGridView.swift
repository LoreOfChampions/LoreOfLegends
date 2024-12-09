//
//  ChampionGridView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import Shimmer

struct ChampionGridView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel
    @State private var shouldPresentSheet: Bool = false

    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: .infinity))]
    
    let champions: [Champion]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if viewModel.selectedChampion != nil || !viewModel.searchingQuery.isEmpty {
                        SearchedChampionView()
                    } else {
                        AlphabeticallySortedChampionsView()
                    }
                }
            }
            .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable {
                await viewModel.load()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Constants.appTitle)
                        .detailLabelStyle(fontSize: 30, color: .gold3)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsButton(shouldPresentSheet: $shouldPresentSheet)
                }
            }
        }
        .overlay {
            if !viewModel.searchingQuery.isEmpty && viewModel.filteredChampions.isEmpty {
                ContentUnavailableView.search(text: viewModel.searchingQuery)
            }
        }
        .fullScreenCover(isPresented: $shouldPresentSheet, content: {
            SettingsView()
        })
    }
}

struct SettingsButton: View {
    @Binding var shouldPresentSheet: Bool

    var body: some View {
        Button {
            shouldPresentSheet = true
        } label: {
            SFSymbols.gear
                .foregroundStyle(.gold3)
        }
    }
}

#Preview {
    ChampionGridView(champions: [.exampleChampion])
}
