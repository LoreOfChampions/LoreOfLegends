//
//  Constants.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation
import SwiftUI

struct Constants {
    static let appTitle = "Lore of League"
    static let darkBlueGradient: Gradient = Gradient(colors: [.blue6, .blue7])
    static let goldGradient: Gradient = Gradient(colors: [.gold5, .gold4])
    static let blueGradient: Gradient = Gradient(colors: [.blue4, .blue2])

    static func buildURLEndpointString(version: String, championID: String? = nil) -> String {
        return "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion\(championID ?? "").json"
    }
}
