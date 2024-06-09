//
//  ChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

struct ChampionsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel
    @State private var selectedLocale: String = "en_US"

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let champions):
                ScrollView {
                    ChampionGridView(champions: champions, selectedLocale: selectedLocale)
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
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.gold3)
                        }
                    }
                }
                .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
                .refreshable {
                    await viewModel.load()
                }
                .overlay {
                    if !viewModel.searchingQuery.isEmpty && viewModel.filteredChampions.isEmpty {
                        ContentUnavailableView.search(text: viewModel.searchingQuery)
                    }
                }
                .padding(.horizontal, 19)
                .scrollIndicators(.hidden)
                .background(.darkBackground)
            case .error(let dataServiceError, let retry):
                LOCErrorView(
                    title: dataServiceError.errorTitle,
                    message: dataServiceError.errorDescription ?? dataServiceError.localizedDescription,
                    buttonTitle: dataServiceError.buttonTitle,
                    buttonAction: {
                        Task {
                            await retry()
                        }
                    }
                )
            }
        }
        .tint(.gold3)
        .task {
            await viewModel.load()
            await viewModel.loadLatestVersion()
            await viewModel.loadLocales()
        }
    }
}

#Preview {
    ChampionsView()
}
