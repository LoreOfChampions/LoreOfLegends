//
//  Constants.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation
import SwiftUI

enum URLs {
    static let baseURL = "https://ddragon.leagueoflegends.com/cdn/"
    static let versionsURL = "https://ddragon.leagueoflegends.com/api/versions.json"
    static let localesURL = "https://ddragon.leagueoflegends.com/cdn/languages.json"
    
    static func buildURLEndpointString(version: String, locale: String = "en_US", championID: String = "") -> String {
        return "https://ddragon.leagueoflegends.com/cdn/\(version)/data/\(locale)/champion\(championID).json"
    }
}

enum Constants {
    static let appTitle = "LoreOfChampions"
    static let favoritesNavigationTitle = "Favorite Champions"
    static let sampleParagraph = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    static let showMore = "Show more..."
    static let showLess = "Show less"
    static let lore = "Lore"
    static let search = "Search"
    static let favorites = "Favorites"
    static let skins = "Skins"
    static let spells = "Spells"
}

enum SFSymbols {
    static let heart = "heart"
    static let heartFill = "heart.fill"
    static let bookFill = "book.fill"
    static let doublePersonFill = "person.and.person.fill"
    static let wandAndStars = "wand.and.stars"
    
    static let magnifyingGlass = Image(systemName: "magnifyingglass")
    static let star = Image(systemName: "star")
    static let gear = Image(systemName: "gear")
    static let chevronLeft = Image(systemName: "chevron.left")
}
