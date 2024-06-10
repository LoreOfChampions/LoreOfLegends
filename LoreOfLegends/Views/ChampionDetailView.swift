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
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var championViewModel: ChampionViewModel
    @StateObject private var viewModel: ChampionDetailViewModel = ChampionDetailViewModel(dataService: LiveDataService())
    @State private var showFullLoreText: Bool = false
    @State private var showFullSpellDescription: Bool = false
    @State private var offset = CGPoint.zero
    @State private var visibleRatio = CGFloat.zero

    private let emptyPassive: ChampionDetail.Passive = ChampionDetail.Passive(
        name: "",
        description: "",
        image: ChampionDetail.Image(full: "", sprite: "", group: "", x: 0, y: 0, w: 0, h: 0)
    )

    let champion: Champion

    init(champion: Champion) {
        self.champion = champion
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let championDetails):
                ForEach(championDetails) { detail in
                    ScrollViewWithStickyHeader(header: {
                        ZStack {
                            ChampionSplashImageView(championDetail: detail)
                            Color.darkBackground
                                .opacity(-visibleRatio * 4 + 1)
                        }
                    }, headerHeight: 400) { offset, headerVisibleRatio in
                        handleOffset(offset, visibleHeaderRatio: headerVisibleRatio)
                    } content: {
                        VStack(spacing: 10) {
                            VStack(alignment: .leading) {
                                ChampionInfoView(viewModel: viewModel, name: detail.name, title: detail.title, tags: detail.tags, visibleRatio: visibleRatio)
                                ChampionLoreView(showFullLoreText: $showFullLoreText, lore: detail.lore ?? "N/A")
                                ChampionSkinsView(championID: detail.id, skins: detail.skins ?? [])
                                ChampionSpellsView(
                                    viewModel: viewModel,
                                    passive: detail.passive ?? ChampionDetail.Passive.init(
                                        name: "",
                                        description: "",
                                        image: .init(
                                            full: "",
                                            sprite: "",
                                            group: "",
                                            x: 0,
                                            y: 0,
                                            w: 0,
                                            h: 0
                                        )
                                    ),
                                    spells: detail.spells ?? [])
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 40)
                        }
                    }
                }
            case .error(let dataServiceError, let retry):
                LOCErrorView(
                    title: dataServiceError.errorTitle,
                    message: dataServiceError.errorDescription ?? dataServiceError.localizedDescription,
                    buttonTitle: dataServiceError.buttonTitle,
                    buttonAction: {
                        Task {
                            await retry()
                        }
                    }
                )
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
            await viewModel.loadChampionDetails(championID: champion.id, locale: championViewModel.selectedLocale)
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
    ChampionDetailView(champion: .exampleChampion)
}
