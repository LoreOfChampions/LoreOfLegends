//
//  ChampionSpellsView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct ChampionSpellsView: View {
    @EnvironmentObject private var viewModel: ChampionDetailViewModel

    let passive: Champion.Passive
    let spells: [Champion.Spell]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Spells", systemImage: "wand.and.stars")
                .detailTitleLabelStyle()
                .padding(.bottom, 5)
            PassiveSpellView(passive: passive)
            SpellView(spells: spells)
        }
    }
}

#Preview {
    ChampionSpellsView(passive: .init(name: "", description: "", image: .init(full: "", sprite: "", group: "", x: 0, y: 0, w: 0, h: 0)), spells: [Champion.Spell(id: "", name: "", description: "")])
}
