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
                url: URL(string:  Constants.baseURL + "img/champion/centered/\(returnCorrectedID(championID: championDetail.id))_0.jpg"),
                urlCache: URLCache.imageCache) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.grey4)
                        .opacity(0.25)
                        .shimmering()
                        .frame(height: 400)
                }

            LinearGradient(colors: [.clear, .darkBackground], startPoint: .top, endPoint: .bottom)
                .frame(height: 100)
        }
    }

    /// Backend is returing incorrect data for only this specific champion called `FiddleSticks`
    /// Many champions consisting from 2 names put together backend returns as `FirstSecond`, but in this case it returns it as `Firstsecond`
    /// So I wrote this simple method to always return correct `string` when `championID.contains("Fiddle")`
    private func returnCorrectedID(championID: String) -> String {
        if championDetail.id.contains("Fiddle") {
            return "FiddleSticks"
        } else {
            return championDetail.id
        }
    }
}

#Preview {
    ChampionSplashImageView(championDetail: ChampionDetail.exampleChampionDetail)
}
