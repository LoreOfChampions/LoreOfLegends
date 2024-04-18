//
//  ChampionSpellsView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct ChampionSpellsView: View {
    let viewModel: ChampionDetailViewModel
    let passive: ChampionDetail.Passive
    let spells: [ChampionDetail.Spell]

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
    ChampionSpellsView(
        viewModel: ChampionDetailViewModel(dataService: MockDataService()),
        passive: .init(name: "", description: "", image: .init(full: "", sprite: "", group: "", x: 0, y: 0, w: 0, h: 0)),
        spells: [ChampionDetail.Spell(id: "", name: "", description: "")]
    )
}
