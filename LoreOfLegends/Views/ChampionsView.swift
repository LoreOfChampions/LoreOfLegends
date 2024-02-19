//
//  ChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

struct ChampionsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                ChampionGridView(isLoading: $isLoading)

                Text(isLoading ? "" : "App version: \(viewModel.version)")
                    .detailLabelStyle(fontSize: 11, color: .gold3)
                    .padding(.vertical)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Constants.appTitle)
                        .detailLabelStyle(fontSize: 30, color: .gold3)
                }
            }
            .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
            .padding(.horizontal, 19)
            .scrollIndicators(.hidden)
            .background(.darkBackground)
        }
        .tint(.gold3)
        .task {
            isLoading = true
            do {
                try await viewModel.getChampions()
            } catch {
                print(LOLError.unableToDecodeData)
            }
            isLoading = false
        }
    }
}

#Preview {
    ChampionsView()
}
