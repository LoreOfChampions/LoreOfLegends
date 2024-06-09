//
//  Constants.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation
import SwiftUI

struct Constants {
    static let appTitle = "LoreOfChampions"
    static let baseURL = "https://ddragon.leagueoflegends.com/cdn/"
    static let localesURL = "https://ddragon.leagueoflegends.com/cdn/languages.json"
    static let sampleParagraph = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    static let darkBlueGradient: Gradient = Gradient(colors: [.blue6, .blue7])
    static let goldGradient: Gradient = Gradient(colors: [.gold5, .gold4])
    static let blueGradient: Gradient = Gradient(colors: [.blue4, .blue2])

    static func buildURLEndpointString(version: String, championID: String = "") -> String {
        return "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion\(championID).json"
    }
}
