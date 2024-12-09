//
//  FavoriteIconView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 06/12/2024.
//

import SwiftUI

struct FavoriteIconView: View {
    let isFavorited: Bool
    let onToggleFavorite: () -> Void
    
    var body: some View {
        Circle()
            .fill(.thinMaterial)
            .frame(width: 38, height: 38)
            .overlay {
                VStack {
                    HStack {
                        Button {
                            onToggleFavorite()
                        } label: {
                            Image(systemName: isFavorited ? SFSymbols.heartFill : SFSymbols.heart)
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                }
                .foregroundStyle(.gold3)
            }
            .padding()
    }
}

#Preview {
    FavoriteIconView(isFavorited: true, onToggleFavorite: {})
}
