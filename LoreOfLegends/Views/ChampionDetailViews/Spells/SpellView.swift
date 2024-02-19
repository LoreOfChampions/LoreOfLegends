//
//  SpellView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct SpellView: View {
    @EnvironmentObject private var viewModel: ChampionDetailViewModel

    let spells: [Champion.Spell]

    var body: some View {
        ForEach(spells) { spell in
            HStack(alignment: .top, spacing: 15) {
                CachedAsyncImage(
                    url: URL(string: Constants.baseURL + "\(viewModel.version)/img/spell/\(spell.id).png"),
                    urlCache: URLCache.imageCache) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.top, 0)

                DisclosureGroup {
                    Text(spell.formattedSpellDescription)
                        .detailLabelStyle(fontSize: 14, color: .gold1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } label: {
                    Text(spell.name)
                        .detailLabelStyle(fontSize: 20, color: .gold3)
                }
                .padding(.top, 0)
            }
        }
    }
}

#Preview {
    SpellView(spells: [Champion.Spell(id: "", name: "", description: "")])
}
