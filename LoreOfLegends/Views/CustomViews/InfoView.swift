//
//  AboutView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 06/03/2024.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel
    @Binding var shouldShowInfoView:  Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            if shouldShowInfoView {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            shouldShowInfoView.toggle()
                        }
                    }

                RoundedRectangle(cornerRadius: 20)
                    .fill(.thinMaterial)
                    .frame(height: 150)
                    .padding(.horizontal, 5)
                    .transition(.move(edge: .bottom))
                    .overlay {
                        InfoViewOverlay(viewModel: viewModel) {
                            shouldShowInfoView.toggle()
                        }
                    }
            }
        }
    }
}

struct InfoViewOverlay: View {
    let viewModel: ChampionViewModel
    var action: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                HStack(alignment: .lastTextBaseline, spacing: 5) {
                    Text("version")
                        .detailLabelStyle(fontSize: 18, color: .gold3)
                    Text("\(viewModel.version)")
                        .detailLabelStyle(fontSize: 24, color: .gold3)
                }
                Spacer()
            }

            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeOut) {
                        action()
                    }
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                .tint(.gold3)
                .clipShape(Circle())
            }
            .padding()
        }
    }
}
