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
    @State private var isPopoverPresented: Bool = false

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
                        isPopoverPresented.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.gold3)
                    }
                    .popover(isPresented: $isPopoverPresented) {
                        AboutView(isPopoverPresented: $isPopoverPresented)
                    }
                }
            }
            .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
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
