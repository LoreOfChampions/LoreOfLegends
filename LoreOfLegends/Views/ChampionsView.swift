//
//  ChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

struct ChampionsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel
    @State private var shouldPresentSheet: Bool = false

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let champions):
                TabView {
                    ChampionGridView(champions: champions)
                        .tabItem {
                            VStack {
                                SFSymbols.magnifyingGlass
                                Text(Constants.search)
                            }
                        }
                    
                    FavoriteListView(champions: viewModel.favoritedChampions)
                        .tabItem {
                            VStack {
                                SFSymbols.star
                                Text(Constants.favorites)
                            }
                        }
                }
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
        }
    }
}

#Preview {
    ChampionsView()
}
