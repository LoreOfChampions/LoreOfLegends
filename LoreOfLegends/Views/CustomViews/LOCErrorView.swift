//
//  LOCErrorView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 15/04/2024.
//

import SwiftUI

struct LOCErrorView: View {
    let title: String
    let message: String
    let buttonTitle: String
    let buttonAction: () -> Void

    var body: some View {
        VStack(spacing: 15) {
            Text(title)
                .detailLabelStyle(fontSize: 22, color: .gold4)
            Text(message)
                .detailLabelStyle(fontSize: 18, color: .gold1)
                .multilineTextAlignment(.center)
                .padding(.bottom)

            Button {
                buttonAction()
            } label: {
                Text(buttonTitle)
                    .detailLabelStyle(fontSize: 18, color: .black)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.gold3)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}

#Preview {
    LOCErrorView(
        title: "Something went wrong!",
        message: "Please check your internet connection and try again.",
        buttonTitle: "Try again",
        buttonAction: {
            print("tapped")
        }
    )
}
