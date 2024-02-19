//
//  ChampionInfoView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI

struct ChampionInfoView: View {
    @EnvironmentObject private var viewModel: ChampionDetailViewModel

    let champion: Champion
    let visibleRatio: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                ForEach(champion.tags, id: \.self) { tag in
                    Image(viewModel.setRoleIcon(for: tag))
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(7)
                        .overlay(
                            Circle()
                                .stroke(.gold2, lineWidth: 2)
                        )
                }
            }

            Text(champion.name)
                .detailLabelStyle(fontSize: 56, color: .gold2)
        }
        .padding(.bottom, 20)
        .opacity(visibleRatio * 5)
    }
}

#Preview {
    ChampionInfoView(champion: Champion.exampleChampion, visibleRatio: .zero)
}
