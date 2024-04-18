//
//  Champion.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation

struct Champion: Codable, Identifiable, Hashable {
    let version: String?
    let id, name: String
    let image: Image
    let tags: [String]

    var formattedTag: String {
        var result = ""

        for tag in tags {
            result += "\(tag)" + (tag != tags.last ? ", " : "")
        }

        return result
    }

    static let exampleChampion = Champion(
        version: "13.18.1",
        id: "Aatrox",
        name: "Aatrox",
        image: Image(
            full: "Aatrox.png",
            sprite: "champion0.png",
            group: "champion", x: 0, y: 0, w: 48, h: 48
        ),
        tags: ["Fighter", "Tank"]
    )

    static func == (lhs: Champion, rhs: Champion) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    struct Image: Codable {
        let full: String
        let sprite: String
        let group: String
        let x, y, w, h: Int
    }
}
