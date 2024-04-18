//
//  DetailLabelStyle.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 19/02/2024.
//

import SwiftUI

struct DetailLabelStyle: ViewModifier {
    let fontSize: CGFloat
    let color: Color

    func body(content: Content) -> some View {
        content
            .font(Fonts.beaufortforLolMedium.withSize(fontSize))
            .foregroundStyle(color)
    }
}

extension View {
    func detailLabelStyle(fontSize: CGFloat, color: Color) -> some View {
        modifier(DetailLabelStyle(fontSize: fontSize, color: color))
    }
}
