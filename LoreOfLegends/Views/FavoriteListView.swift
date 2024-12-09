//
//  FavoriteListView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 06/12/2024.
//

import SwiftUI
import CachedAsyncImage

struct FavoriteListView: View {
    let champions: [Champion]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(champions, id: \.id) { champion in
                    NavigationLink {
                        ChampionDetailView(champion: champion)
                    } label: {
                        HStack {
                            CachedAsyncImage(
                                url: URL(string: URLs.baseURL + "img/champion/splash/\(champion.id)_0.jpg"),
                                urlCache: URLCache.imageCache) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
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
                                            Text(champion.name)
                                                .detailLabelStyle(fontSize: 26, color: .gold2)
                                        }
                                    }
                                    .padding()
                                }
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .navigationTitle(Constants.favoritesNavigationTitle)
        }
    }
}

#Preview {
    FavoriteListView(champions: [.exampleChampion, .exampleChampion])
}
