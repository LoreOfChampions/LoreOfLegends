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
    @State private var shouldShowInfoView: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                ChampionGridView(isLoading: $isLoading)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Constants.appTitle)
                        .detailLabelStyle(fontSize: 30, color: .gold3)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.easeIn) {
                            shouldShowInfoView.toggle()
                        }
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.gold3)
                    }
                }
            }
            .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable(action: {
                do {
                    try await viewModel.getChampions()
                } catch {
                    print(LOLError.unableToDecodeData)
                }
            })
            .overlay {
                if !viewModel.searchingQuery.isEmpty && viewModel.filteredChampions.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchingQuery)
                }
            }
            .padding(.horizontal, 19)
            .scrollIndicators(.hidden)
            .background(.darkBackground)
        }
        .tint(.gold3)
        .overlay {
            InfoView(shouldShowInfoView: $shouldShowInfoView)
        }
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
