//
//  LoreOfLegends.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

@main
struct LoreOfLegends: App {
    init() {
        Fonts.registerFontsIfNeeded()
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.gold2]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.gold2]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                ChampionsView()
                    .environmentObject(ChampionViewModel(dataService: LiveDataService()))
            }
            .preferredColorScheme(.dark)
        }
    }
}
