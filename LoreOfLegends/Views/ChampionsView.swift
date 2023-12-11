//
//  ChampionsView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

struct ChampionsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    // This internal init is here to basically set the different appearance to the UINavigationBar
    internal init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gold3]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gold3]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.shouldShowGridLayout {
                    ChampionListView()
                } else {
                    ChampionGridView()
                }
            }
            .navigationTitle(Constants.appTitle)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SwiftUI.Image(systemName: viewModel.layoutButton)
                        .foregroundStyle(Color.gold3)
                        .onTapGesture {
                            withAnimation {
                                viewModel.shouldShowGridLayout.toggle()
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            .background(.darkBackground)
        }
        .tint(Color.gold3)
        .task {
            try? await viewModel.getChampions()
        }
    }
}

#Preview {
    ChampionsView()
}