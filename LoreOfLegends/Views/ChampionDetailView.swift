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
    @Environment(\.dismiss) private var dismiss
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
                    championSkinView
                    championSpells
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .background(.darkBackground)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(champion.id)
                    .opacity(visibleRatio < 0 ? 1 : 0)
                    .foregroundStyle(.gold3)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundStyle(.gold3)
                }
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
        VStack(alignment: .leading, spacing: 0) {
            Label("Skins", systemImage: "person.and.person.fill")
                .detailTitleLabelStyle()

            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(skins, id: \.id) { skin in
                        VStack {
                            CachedAsyncImage(
                                url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.id)_\(skin.num).jpg"),
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

                            Text(skin.name == "default" ? champion.id : skin.name)
                                .font(Fonts.beaufortforLolBold.withSize(15))
                                .foregroundStyle(.gold2)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .safeAreaPadding(.horizontal)
        }
    }

    private var championInfo: some View {
        return HStack(alignment: .lastTextBaseline, spacing: 10) {
            Text(champion.name)
                .font(Fonts.beaufortforLolBold.withSize(52))
                .foregroundStyle(.gold2)
                .opacity(visibleRatio * 5)

            HStack(spacing: 5) {
                ForEach(champion.tags, id: \.self) { tag in
                    Image(setRoleIcon(for: tag))
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
            .opacity(visibleRatio * 5)
        }
    }

    private var championLore: some View {
        return Group {
            Label("Lore", systemImage: "book.fill")
                .detailTitleLabelStyle()

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
                .detailTitleLabelStyle()

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
                    Text(passive.formattedPassiveDescription)
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
                        Text(spell.formattedSpellDescription)
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

    private func setRoleIcon(for tag: String) -> String {
        if tag == "Assassin" {
            return "assasinIcon"
        } else if tag == "Fighter" {
            return "fighterIcon"
        } else if tag == "Mage" {
            return "mageIcon"
        } else if tag == "Marksman" {
            return "marksmanIcon"
        } else if tag == "Support" {
            return "supportIcon"
        } else if tag == "Tank" {
            return "tankIcon"
        } else {
            return ""
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

#Preview {
    ChampionDetailView(champion: Champion.exampleChampion)
}
