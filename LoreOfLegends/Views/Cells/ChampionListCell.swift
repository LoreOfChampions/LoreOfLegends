//
//  ChampionListCell.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import CachedAsyncImage

struct ChampionListCell: View {

    let champion: Champion

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            HStack(spacing: 20) {
                CachedAsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(champion.id)_0.jpg"), urlCache: URLCache.imageCache) { image in
                    image
                        .resizable()
                        .aspectRatio(0.7, contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.grey6)
                        .frame(width: 100, height: 150)
                        .opacity(0.5)
                        .overlay {
                            ProgressView()
                        }
                }
                .padding(.leading)

                VStack(alignment: .leading) {
                    Text(champion.name)
                        .font(Fonts.beaufortforLolBold.withSize(32))
                        .foregroundStyle(.gold3)

                    HStack(spacing: 0) {
                        Text(champion.formattedTag)
                            .font(Fonts.beaufortforLolBold.withSize(15))
                            .foregroundStyle(.gold1)
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(.grey3.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 20))

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ChampionListCell(champion: Champion.exampleChampion)
}
