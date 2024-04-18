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
