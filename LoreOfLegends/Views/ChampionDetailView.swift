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
                ChampionSplashImageView(champion: champion)
                Color.darkBackground
                    .opacity(-visibleRatio * 4 + 1)
            }
        }, headerHeight: 400) { offset, headerVisibleRatio in
            handleOffset(offset, visibleHeaderRatio: headerVisibleRatio)
        } content: {
            VStack(spacing: 10) {
                VStack(alignment: .leading) {
                    ChampionInfoView(champion: champion, visibleRatio: visibleRatio)
                    ChampionLoreView(showFullLoreText: $showFullLoreText, lore: lore)
                    ChampionSkinsView(champion: champion, skins: skins)
                    ChampionSpellsView(passive: passive, spells: spells)
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

    private func handleOffset(_ scrollOffset: CGPoint, visibleHeaderRatio: CGFloat) {
        self.offset = scrollOffset
        self.visibleRatio = visibleHeaderRatio
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
