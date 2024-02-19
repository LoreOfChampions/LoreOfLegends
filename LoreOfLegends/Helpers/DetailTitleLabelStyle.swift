//
//  DetailTitleLabelStyle.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 04/01/2024.
//

import SwiftUI

struct DetailTitleLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.beaufortforLolMedium.withSize(40))
            .foregroundStyle(.gold2)
    }
}

extension View {
    func detailTitleLabelStyle() -> some View {
        modifier(DetailTitleLabelStyle())
    }
}
