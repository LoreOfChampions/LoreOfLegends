//
//  ChampionSkinsView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct ChampionSkinsView: View {

    let champion: Champion
    let skins: [Champion.Skin]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Skins", systemImage: "person.and.person.fill")
                .detailTitleLabelStyle()
                .padding(.bottom, 5)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(skins, id: \.id) { skin in
                        VStack(spacing: 10) {
                            CachedAsyncImage(
                                url: URL(string: Constants.baseURL + "img/champion/splash/\(champion.id)_\(skin.num).jpg"),
                                urlCache: URLCache.imageCache) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                        .padding(.horizontal, 5)
                                        .containerRelativeFrame(.horizontal)
                                } placeholder: {
                                    ProgressView()
                                }
                                .padding(.bottom, 5)

                            Text(skin.name == "default" ? champion.id : skin.name)
                                .detailLabelStyle(fontSize: 15, color: .gold2)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .safeAreaPadding(.horizontal)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    ChampionSkinsView(champion: Champion.exampleChampion, skins: [])
}
