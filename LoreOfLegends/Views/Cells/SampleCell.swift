//
//  SampleCell.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 14/12/2023.
//

import SwiftUI

struct SampleCell: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.grey4)
                .frame(height: 326)

            Text("champion.id")
                .font(Fonts.beaufortforLolBold.withSize(23))
                .foregroundStyle(.gold2)

            HStack(spacing: 0) {
                Text("champion.formattedTag")
                    .font(Fonts.beaufortforLolBold.withSize(11))
                    .foregroundStyle(.gold1)
            }
        }
    }
}

#Preview {
    SampleCell()
}
