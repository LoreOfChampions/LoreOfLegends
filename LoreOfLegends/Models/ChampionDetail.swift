//
//  ChampionDetail.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 16/04/2024.
//

import Foundation

struct ChampionDetail: Codable, Identifiable, Hashable {
    let version: String?
    let id, key, name, title: String
    let lore: String?
    let image: Image
    let skins: [Skin]?
    let spells: [Spell]?
    let passive: Passive?
    let tags: [ChampionTag]

    var formattedTag: String {
        var result = ""

        for tag in tags {
            result += "\(tag)" + (tag != tags.last ? ", " : "")
        }

        return result
    }

    static let exampleChampionDetail = ChampionDetail(
        version: "13.18.1",
        id: "Aatrox",
        key: "266",
        name: "Aatrox",
        title: "the Darkin Blade",
        lore: "Once honored defenders of Shurima against the Void, Aatrox and his brethren would eventually become an even greater threat to Runeterra, and were defeated only by cunning mortal sorcery. But after centuries of imprisonment, Aatrox was the first to find freedom once more, corrupting and transforming those foolish enough to try and wield the magical weapon that contained his essence. Now, with stolen flesh, he walks Runeterra in a brutal approximation of his previous form, seeking an apocalyptic and long overdue vengeance.",
        image: Image(
            full: "Aatrox.png",
            sprite: "champion0.png",
            group: "champion", x: 0, y: 0, w: 48, h: 48
        ),
        skins: [Skin(
            id: "266000",
            num: 1,
            name: "default",
            chromas: false)
        ],
        spells: [Spell(
            id: "AatroxQ",
            name: "The Darkin Blade",
            description: "Aatrox slams his greatsword down, dealing physical damage. He can swing three times, each with a different area of effect.")
        ],
        passive: Passive(
            name: "Deathbringer Stance",
            description: "Periodically, Aatrox's next basic attack deals bonus <physicalDamage>physical damage</physicalDamage> and heals him, based on the target's max health.",
            image: Image(
                full: "Aatrox_Passive.png",
                sprite: "passive0.png",
                group: "passive",
                x: 0,
                y: 0,
                w: 48,
                h: 48
            )),
        tags: [.assassin, .marksman]
    )

    static func == (lhs: ChampionDetail, rhs: ChampionDetail) -> Bool {
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

    struct Skin: Codable, Identifiable, Hashable {
        let id: String
        let num: Int
        let name: String
        let chromas: Bool
    }

    struct Spell: Codable, Identifiable {
        let id: String
        let name: String
        let description: String

        var formattedSpellDescription: String {
            var result = self.description

            result = result.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)

            return result
        }
    }

    struct Passive: Codable {
        let name: String
        let description: String
        let image: ChampionDetail.Image

        var formattedPassiveDescription: String {
            var result = self.description

            result = result.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

            return result
        }
    }
}

