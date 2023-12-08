//
//  TabView+ext.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import UIKit
import SwiftUI

struct TabViewPageIndicatorBackgroundColor: ViewModifier {
    var pageIndicatorColor: UIColor
    var currentPageIndicatorColor: UIColor

    func body(content: Content) -> some View {
        content
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = currentPageIndicatorColor
                UIPageControl.appearance().pageIndicatorTintColor = pageIndicatorColor.withAlphaComponent(0.2)
            }
    }
}

extension TabView {
    func tintPageViewControllers(pageIndicatorColor: UIColor, currentPageIndicatorColor: UIColor) -> some View {
        self.modifier(TabViewPageIndicatorBackgroundColor(pageIndicatorColor: pageIndicatorColor, currentPageIndicatorColor: currentPageIndicatorColor))
    }
}
