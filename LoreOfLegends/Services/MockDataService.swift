//
//  MockDataService.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 12/04/2024.
//

import Foundation

class MockDataService: DataServiceProtocol {
    func getChampions() async -> Result<[Champion], DataServiceError> {
        try? await Task.sleep(for: .milliseconds(500))

        let champion = Champion(
            version: "14.7.1",
            id: "Aatrox",
            name: "Aatrox",
            image: .init(
                full: "Aatrox.png",
                sprite: "champion0.png",
                group: "champion", x: 0, y: 0, w: 48, h: 48
            ),
            tags: ["Fighter", "Tank"]
        )

        return .success([champion])
    }

    func fetchVersion() async -> Result<String, DataServiceError> {
        try? await Task.sleep(for: .milliseconds(500))

        return .success("1.0.0")
    }

    func fetchChampionDetails(championID: String) async -> Result<[ChampionDetail], DataServiceError> {
        try? await Task.sleep(for: .milliseconds(500))

        let championDetail = ChampionDetail(
            version: "14.7.1",
            id: "Aatrox",
            key: "266",
            name: "Aatrox",
            title: "the Darking Blade",
            lore: "nionoinionoi",
            image: .init(
                full: "Aatrox.png",
                sprite: "champion0.png",
                group: "champion",
                x: 0,
                y: 0,
                w: 48,
                h: 48
            ),
            skins: [.init(
                id: "266000",
                num: 1,
                name: "default",
                chromas: false)
            ],
            spells: [.init(
                id: "AatroxQ",
                name: "The Darkin Blade",
                description: "Aatrox slams his greatsword down, dealing physical damage. He can swing three times, each with a different area of effect.")
            ],
            passive: .init(
                name: "Deathbringer Stance",
                description: "Periodically, Aatrox's next basic attack deals bonus <physicalDamage>physical damage</physicalDamage> and heals him, based on the target's max health.",
                image: .init(
                    full: "Aatrox_Passive.png",
                    sprite: "passive0.png",
                    group: "passive",
                    x: 0,
                    y: 0,
                    w: 48,
                    h: 48
                )
            ),
            tags: ["Fighter", "Tank"]
        )

        return .success([championDetail])
    }
}
