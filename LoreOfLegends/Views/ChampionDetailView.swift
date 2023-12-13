//
//  ChampionDetailView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import CachedAsyncImage
import ScrollKit

struct ChampionDetailView: View {
    @EnvironmentObject private var viewModel: ChampionDetailViewModel
    @State private var showFullLoreText: Bool = false
    @State private var showFullSpellDescription: Bool = false

    @State private var spells: [Champion.Spell] = []
    @State private var skins: [Champion.Skin] = []
    @State private var lore = ""
    @State private var passive: Champion.Passive = Champion.Passive(name: "", description: "", image: Champion.Image(full: "", sprite: "", group: "", x: 0, y: 0, w: 0, h: 0))

    @State private var offset = CGPoint.zero
    @State private var visibleRatio = CGFloat.zero

    let champion: Champion

    init(champion: Champion) {
        self.champion = champion
    }

    var body: some View {
        ScrollViewWithStickyHeader(header: {
            ZStack {
                if visibleRatio > 0 {
                    championSplashImageView
                        .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .top)))
                } else {
                    Color.darkBackground
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .opacity))
                }
            }
        }, headerHeight: 400) { offset, headerVisibleRatio in
            handleOffset(offset, visibleHeaderRatio: headerVisibleRatio)
        } content: {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    championInfo
                    championLore
                    championSpells
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .scrollIndicators(.hidden)
        .background(.darkBackground)
        .task {
            do {
                let championData = try await viewModel.fetchChampionDetails(championID: champion.id)
                if let championDetails = championData.data[champion.id] {
                    skins = championDetails.skins ?? []
                    lore = championDetails.lore ?? ""
                    spells = championDetails.spells ?? []
                    passive = championDetails.passive ?? .init(name: "", description: "", image: Champion.Image(full: "", sprite: "", group: "", x: 0, y: 0, w: 48, h: 48))
                }
            } catch {
                print(error)
            }
        }
    }

    private var championSplashImageView: some View {
        ZStack(alignment: .bottom) {
            CachedAsyncImage(
                url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.id)_0.jpg"),
                urlCache: URLCache.imageCache) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }

            LinearGradient(colors: [.clear, .darkBackground], startPoint: .top, endPoint: .bottom)
                .frame(height: 150)
        }
    }

    private var skinTabView: some View {
        TabView {
            ForEach(skins) { skin in
                CachedAsyncImage(
                    url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.id)_\(skin.num).jpg"),
                    urlCache: URLCache.imageCache) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
            }
        }
        .tintPageViewControllers(pageIndicatorColor: .gold3, currentPageIndicatorColor: .gold3)
        .tabViewStyle(PageTabViewStyle())
        .frame(
            width: UIScreen.main.bounds.width ,
            height: UIScreen.main.bounds.height / 1.75
        )
    }

    private var championInfo: some View {
        return HStack(alignment: .lastTextBaseline, spacing: 10) {
            Text(champion.name)
                .font(Fonts.beaufortforLolBold.withSize(52))
                .foregroundStyle(.gold2)

            HStack(spacing: 0) {
                Text("(\(champion.formattedTag))")
                    .font(Fonts.beaufortforLolBold.withSize(15))
                    .foregroundStyle(.gold2)
            }
            .padding(.bottom)
        }
    }

    private var championLore: some View {
        return Group {
            Text("Lore:")
                .font(Fonts.beaufortforLolBold.withSize(40))
                .foregroundStyle(.gold2)

            VStack {
                Text(lore)
                    .font(Fonts.beaufortforLolBold.withSize(18))
                    .lineLimit(showFullLoreText ? nil : 5)
                    .foregroundStyle(.gold1)

                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showFullLoreText.toggle()
                        }
                    }) {
                        Text(showFullLoreText ? "Show Less" : "Show More")
                            .font(Fonts.beaufortforLolBold.withSize(18))
                            .foregroundStyle(.gold3)
                    }
                    .padding(.trailing)
                }
            }
            .padding(.bottom, 20)
        }
    }

    private var championSpells: some View {
        return VStack(alignment: .leading) {
            Text("Spells:")
                .font(Fonts.beaufortforLolBold.withSize(40))
                .foregroundStyle(.gold2)

            HStack(spacing: 10) {
                CachedAsyncImage(
                    url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.23.1/img/passive/\(passive.image.full)"),
                    urlCache: URLCache.imageCache) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    } placeholder: {
                        ProgressView()
                    }

                VStack(alignment: .leading) {
                    HStack {
                        Text(passive.name)
                            .font(Fonts.beaufortforLolBold.withSize(20))
                            .foregroundStyle(.gold3)
                        Text("(Passive)")
                            .font(Fonts.beaufortforLolBold.withSize(16))
                            .foregroundStyle(.gold3)
                    }
                    Text(passive.removeHtmlTags(from: passive.description))
                        .font(Fonts.beaufortforLolBold.withSize(12))
                        .lineLimit(showFullSpellDescription ? nil : 2)
                        .foregroundStyle(.gold1)
                }
            }
            .onTapGesture {
                withAnimation {
                    showFullSpellDescription.toggle()
                }
            }
            .padding()
            .background(Color.grey1.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15))

            ForEach(spells) { spell in
                HStack(spacing: 10) {
                    CachedAsyncImage(
                        url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/\(spell.id).png"),
                        urlCache: URLCache.imageCache) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        } placeholder: {
                            ProgressView()
                        }

                    VStack(alignment: .leading) {
                        Text(spell.name)
                            .font(Fonts.beaufortforLolBold.withSize(20))
                            .foregroundStyle(.gold3)
                        Text(spell.description)
                            .font(Fonts.beaufortforLolBold.withSize(12))
                            .lineLimit(showFullSpellDescription ? nil : 2)
                            .foregroundStyle(.gold1)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        showFullSpellDescription.toggle()
                    }
                }
                .padding()
                .background(Color.grey1.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }

    private func handleOffset(_ scrollOffset: CGPoint, visibleHeaderRatio: CGFloat) {
        self.offset = scrollOffset
        self.visibleRatio = visibleHeaderRatio
    }
}

#Preview {
    ChampionDetailView(champion: Champion.exampleChampion)
}
