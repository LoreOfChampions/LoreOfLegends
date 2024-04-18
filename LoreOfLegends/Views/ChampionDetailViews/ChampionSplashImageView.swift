//
//  ChampionSplashImageView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct ChampionSplashImageView: View {
    let championDetail: ChampionDetail

    var body: some View {
        ZStack(alignment: .bottom) {
            CachedAsyncImage(
                url: URL(string:  Constants.baseURL + "img/champion/centered/\(championDetail.id)_0.jpg"),
                urlCache: URLCache.imageCache) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }

            LinearGradient(colors: [.clear, .darkBackground], startPoint: .top, endPoint: .bottom)
                .frame(height: 100)
        }
    }
}

#Preview {
    ChampionSplashImageView(championDetail: ChampionDetail.exampleChampionDetail)
}
