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

    // This internal init is here to basically set the different appearance to the UINavigationBar
    internal init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gold3]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gold3]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                ChampionGridView(isLoading: $isLoading)

                Text("App version: \(viewModel.version)")
                    .font(Fonts.beaufortforLolLight.withSize(11))
                    .foregroundStyle(Color.gold3)
                    .padding(.vertical)
            }
            .navigationTitle(Constants.appTitle)
            .searchable(text: $viewModel.searchingQuery, placement: .navigationBarDrawer(displayMode: .always))
            .padding(.horizontal, 19)
            .scrollIndicators(.hidden)
            .background(.darkBackground)
        }
        .tint(Color.gold3)
        .task {
            do {
                try await viewModel.getChampions()
            } catch {
                print(LOLError.unableToDecodeData)
            }
        }
    }
}

#Preview {
    ChampionsView()
}
