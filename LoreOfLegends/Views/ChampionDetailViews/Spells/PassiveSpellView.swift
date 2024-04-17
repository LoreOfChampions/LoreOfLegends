//
//  PassiveSpellView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct PassiveSpellView: View {
    @EnvironmentObject private var viewModel: ChampionDetailViewModel

    let passive: ChampionDetail.Passive

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            CachedAsyncImage(
                url: URL(string: Constants.baseURL + "14.7.1/img/passive/\(passive.image.full)"),
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
                Text(passive.formattedPassiveDescription)
                    .detailLabelStyle(fontSize: 14, color: .gold1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } label: {
                HStack {
                    Text(passive.name)
                        .detailLabelStyle(fontSize: 20, color: .gold3)

                    Text("(Passive)")
                        .detailLabelStyle(fontSize: 14, color: .gold3)
                }
            }
            .padding(.top, 0)
        }
    }
}

#Preview {
    PassiveSpellView(passive: .init(name: "", description: "", image: .init(full: "", sprite: "", group: "", x: 0, y: 0, w: 0, h: 0)))
}
