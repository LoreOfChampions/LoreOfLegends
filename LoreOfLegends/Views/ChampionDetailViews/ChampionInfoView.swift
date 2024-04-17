//
//  ChampionInfoView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI

struct ChampionInfoView: View {
    let viewModel: ChampionDetailViewModel
    let name: String
    let tags: [String]
    let visibleRatio: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                ForEach(tags, id: \.self) { tag in
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

            Text(name)
                .detailLabelStyle(fontSize: 56, color: .gold2)
        }
        .padding(.bottom, 20)
        .opacity(visibleRatio * 5)
    }
}

#Preview {
    ChampionInfoView(viewModel: ChampionDetailViewModel(dataService: MockDataService()), name: "", tags: [""], visibleRatio: 0)
}
