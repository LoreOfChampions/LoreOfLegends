//
//  ChampionDetailView.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import SwiftUI
import CachedAsyncImage
import ScrollKit
import Shimmer

struct ChampionDetailView: View {
    @EnvironmentObject private var viewModel: ChampionDetailViewModel
    @State private var showFullLoreText: Bool = false
    @State private var showFullSpellDescription: Bool = false

    @State private var spells: [Champion.Spell] = []
    @State private var skins: [Champion.Skin] = []
    @State private var lore: String = ""
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
                championSplashImageView
                Color.darkBackground
                    .opacity(-visibleRatio * 4 + 1)
            }
        }, headerHeight: 400) { offset, headerVisibleRatio in
            handleOffset(offset, visibleHeaderRatio: headerVisibleRatio)
        } content: {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    championInfo
                    championLore
                    championSpells
                    championSkinView
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .scrollIndicators(.hidden)
        .background(.darkBackground)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(champion.id)
                    .opacity(visibleRatio < 0 ? 1 : 0)
                    .foregroundStyle(.gold3)
            }
        }
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
                print(LOLError.unableToDecodeData)
            }
        }
    }

    private var championSplashImageView: some View {
        ZStack(alignment: .bottom) {
            CachedAsyncImage(
                url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/centered/\(champion.id)_0.jpg"),
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

    private var championSkinView: some View {
        Group {
            Label("Skins", systemImage: "repeat")
                .font(Fonts.beaufortforLolBold.withSize(40))
                .foregroundStyle(.gold2)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(skins, id: \.id) { skin in
                        CachedAsyncImage(
                            url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.id)_\(skin.num).jpg"),
                            urlCache: URLCache.imageCache) { image in
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .containerRelativeFrame(.horizontal)
                                    .frame(height: 220)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .frame(height: 220)
        }
    }

    private var championInfo: some View {
        return HStack(alignment: .lastTextBaseline, spacing: 10) {
            Text(champion.name)
                .font(Fonts.beaufortforLolBold.withSize(52))
                .foregroundStyle(.gold2)
                .opacity(visibleRatio * 5)

            HStack(spacing: 0) {
                Text("(\(champion.formattedTag))")
                    .font(Fonts.beaufortforLolBold.withSize(15))
                    .foregroundStyle(.gold2)
                    .opacity(visibleRatio * 5)
            }
            .padding(.bottom)
        }
    }

    private var championLore: some View {
        return Group {
            Label("Lore", systemImage: "book.fill")
                .font(Fonts.beaufortforLolBold.withSize(40))
                .foregroundStyle(.gold2)

            VStack(spacing: 10) {
                if lore.isEmpty {
                    Text(Constants.sampleParagraph)
                        .font(Fonts.beaufortforLolBold.withSize(18))
                        .lineLimit(showFullLoreText ? nil : 5)
                        .foregroundStyle(.gold1)
                        .redacted(reason: .placeholder)
                        .shimmering()
                } else {
                    Text(lore)
                        .font(Fonts.beaufortforLolBold.withSize(18))
                        .lineLimit(showFullLoreText ? nil : 5)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(.gold1)
                }
            }
            .onTapGesture {
                showFullLoreText.toggle()
            }
            .padding(.bottom)
        }
    }

    private var championSpells: some View {
        return VStack(alignment: .leading, spacing: 0) {
            Label("Spells", systemImage: "wand.and.stars")
                .font(Fonts.beaufortforLolBold.withSize(40))
                .foregroundStyle(.gold2)

            HStack(spacing: 10) {
                CachedAsyncImage(
                    url: URL(string: "https://ddragon.leagueoflegends.com/cdn/\(viewModel.version)/img/passive/\(passive.image.full)"),
                    urlCache: URLCache.imageCache) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    } placeholder: {
                        ProgressView()
                    }

                DisclosureGroup {
                    Text(passive.removeHtmlTags(from: passive.description))
                        .font(Fonts.beaufortforLolBold.withSize(12))
                        .foregroundStyle(.gold1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } label: {
                    HStack {
                        Text(passive.name)
                            .font(Fonts.beaufortforLolBold.withSize(20))
                            .foregroundStyle(.gold3)

                        Text("(Passive)")
                            .font(Fonts.beaufortforLolBold.withSize(14))
                            .foregroundStyle(.gold3)
                    }
                }
            }

            ForEach(spells) { spell in
                HStack(spacing: 10) {
                    CachedAsyncImage(
                        url: URL(string: "https://ddragon.leagueoflegends.com/cdn/\(viewModel.version)/img/spell/\(spell.id).png"),
                        urlCache: URLCache.imageCache) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        } placeholder: {
                            ProgressView()
                        }

                    DisclosureGroup {
                        Text(spell.description)
                            .font(Fonts.beaufortforLolBold.withSize(12))
                            .foregroundStyle(.gold1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } label: {
                        Text(spell.name)
                            .font(Fonts.beaufortforLolBold.withSize(20))
                            .foregroundStyle(.gold3)
                    }
                }
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
