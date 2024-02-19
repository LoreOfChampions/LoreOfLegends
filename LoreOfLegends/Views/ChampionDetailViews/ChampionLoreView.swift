//
//  ChampionLoreView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI

struct ChampionLoreView: View {
    @Binding var showFullLoreText: Bool

    let lore: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Lore", systemImage: "book.fill")
                .detailTitleLabelStyle()

            VStack(spacing: 10) {
                VStack {
                    if lore.isEmpty {
                        Text(Constants.sampleParagraph)
                            .detailLabelStyle(fontSize: 18, color: .gold1)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    } else {
                        Text(lore)
                            .detailLabelStyle(fontSize: 18, color: .gold1)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .overlay {
                    withAnimation(.easeInOut) {
                        LinearGradient(
                            stops: [
                                .init(color: .darkBackground, location: 0),
                                .init(color: .darkBackground, location: 0.25),
                                .init(color: .clear, location: 1)
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .opacity(showFullLoreText ? 0 : 1)
                    }
                }

                if !lore.isEmpty {
                    withAnimation(.easeInOut) {
                        Button {
                            withAnimation(.spring) {
                                showFullLoreText.toggle()
                            }
                        } label: {
                            Text(showFullLoreText ? "Read less" : "Read more...")
                                .detailLabelStyle(fontSize: 18, color: .gold2)
                        }
                        .offset(y: showFullLoreText ? 0 : -50)
                    }
                }
            }
            .padding(.bottom, showFullLoreText ? 20 : 0)
        }
    }
}

#Preview {
    ChampionLoreView(showFullLoreText: .constant(false), lore: "")
}
