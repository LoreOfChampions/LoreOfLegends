//
//  ChampionTag.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 07/06/2024.
//

import Foundation

enum ChampionTag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"

    var championIcon: String {
        switch self {
        case .assassin:
            return "assasinIcon"
        case .fighter:
            return "fighterIcon"
        case .mage:
            return "mageIcon"
        case .marksman:
            return "marksmanIcon"
        case .support:
            return "supportIcon"
        case .tank:
            return "tankIcon"
        }
    }
}
