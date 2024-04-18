//
//  SampleCell.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 14/12/2023.
//

import SwiftUI

struct SampleCell: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.grey4)
                .frame(height: 326)

            Text("champion.id")
                .detailLabelStyle(fontSize: 23, color: .gold2)

            HStack(spacing: 0) {
                Text("champion.formattedTag")
                    .detailLabelStyle(fontSize: 11, color: .gold1)
            }
        }
    }
}

#Preview {
    SampleCell()
}
