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

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CachedAsyncImage(
                url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(champion.id)_0.jpg"),
                urlCache: URLCache.imageCache) { phase in
                    switch phase {
                    case .empty:
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
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .failure:
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.thinMaterial)
                            .frame(height: 326)
                            .overlay {
                                VStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                    Text("Couldn't load the image!")
                                }
                            }
                    @unknown default:
                        fatalError()
                    }
                }

            Text(champion.name)
                .detailLabelStyle(fontSize: 26, color: .gold2)

            HStack(spacing: 0) {
                Text(champion.formattedTag)
                    .detailLabelStyle(fontSize: 14, color: .gold1)
            }
        }
    }
}

#Preview {
    ChampionGridCell(champion: Champion.exampleChampion)
}
