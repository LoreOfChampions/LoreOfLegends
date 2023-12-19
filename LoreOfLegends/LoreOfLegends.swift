//
//  LoreOfLegends.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI

@main
struct LoreOfLegends: App {
    @State private var version: String?

    init() {
        Fonts.registerFontsIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                if let version {
                    ChampionsView()
                        .environmentObject(ChampionViewModel(version: version))
                        .environmentObject(ChampionDetailViewModel(version: version))
                }
            }
            .preferredColorScheme(.dark)
            .task {
                do {
                    version = try await VersionViewModel.fetchLatestVersion()
                } catch {
                    print("Couldn't fetch the latest version")
                }
            }
        }
    }
}
