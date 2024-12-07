//
//  ChampionGridCell.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import CachedAsyncImage
import Shimmer

struct ChampionGridCell: View {
    let champion: Champion
    
    let isFavorited: Bool
    let onToggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CachedAsyncImage(
                url: URL(string: Constants.baseURL + "img/champion/loading/\(champion.id)_0.jpg"),
                urlCache: URLCache.imageCache) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 326)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.grey6)
                        .frame(height: 326)
                        .opacity(0.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.grey4)
                                .frame(height: 326)
                                .shimmering()
                        }
                }
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            FavoriteIconView(isFavorited: isFavorited, onToggleFavorite: {
                                onToggleFavorite()
                            })
                        }
                    }
                }

            Text(champion.name)
                .detailLabelStyle(fontSize: 26, color: .gold2)
                .lineLimit(1)

            HStack(spacing: 0) {
                Text(champion.formattedTag)
                    .detailLabelStyle(fontSize: 14, color: .gold1)
            }
        }
    }
}

#Preview {
    ChampionGridCell(champion: Champion.exampleChampion, isFavorited: true, onToggleFavorite: {})
}
