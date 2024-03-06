//
//  AboutView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 06/03/2024.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel
    @Binding var isPopoverPresented: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button {
                    isPopoverPresented.toggle()
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.gold3)
                        .clipShape(Circle())
                }
            }
            .padding([.trailing, .vertical])

            Spacer()

            VStack {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.gold3)
                Text("App version: \(viewModel.version)")
                    .detailLabelStyle(fontSize: 30, color: .gold3)
                    .padding(.vertical)
            }

            Spacer()
        }
    }
}

#Preview {
    AboutView(isPopoverPresented: .constant(false))
}
