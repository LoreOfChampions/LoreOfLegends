//
//  ChampionGridCell.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import CachedAsyncImage

struct ChampionGridCell: View {

    let champion: Champion

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CachedAsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(champion.id)_0.jpg"), urlCache: URLCache.imageCache) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.grey6)
                    .frame(height: 326)
                    .opacity(0.5)
                    .overlay {
                        ProgressView()
                            .tint(Color.gold3)
                    }
            }
            .padding(.leading, -6)

            Text(champion.name)
                .font(Fonts.beaufortforLolBold.withSize(23))
                .foregroundStyle(.gold2)

            HStack(spacing: 0) {
                Text(champion.formattedTag)
                    .font(Fonts.beaufortforLolBold.withSize(11))
                    .foregroundStyle(.gold1)
            }
        }
    }
}

#Preview {
    ChampionGridCell(champion: Champion.exampleChampion)
}
