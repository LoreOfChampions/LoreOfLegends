//
//  Typography.swift
//  LoreOfLegends
//
//  Created by Peter Mihók on 07/12/2023.
//

import Foundation
import SwiftUI
import UIKit

public enum Fonts: CaseIterable {
    case spiegelBoldItalic
    case spiegelBold
    case spiegelRegularItalic
    case spiegelSemiBold
    case spiegelSemiBoldItalic
    case spiegelRegular
    case beaufortforLolMedium
    case beaufortforLolLightItalic
    case beaufortforLolBoldItalic
    case beaufortforLolMediumItalic
    case beaufortforLolRegular
    case beaufortforLolHeavyItalic
    case beaufortforLolHeavy
    case beaufortforLolBold
    case beaufortforLolLight
    case beaufortforLolItalic

    var fileName: String? {
        switch self {
        case .spiegelBoldItalic:
            return "Spiegel-BoldItalic"
        case .spiegelBold:
            return "Spiegel-Bold"
        case .spiegelRegularItalic:
            return "Spiegel-RegularItalic"
        case .spiegelSemiBold:
            return "Spiegel-SemiBold"
        case .spiegelSemiBoldItalic:
            return "Spiegel-SemiBoldItalic"
        case .spiegelRegular:
            return "Spiegel-Regular"
        case .beaufortforLolMedium:
            return "BeaufortforLOL-Medium"
        case .beaufortforLolLightItalic:
            return "BeaufortforLOL-LightItalic"
        case .beaufortforLolBoldItalic:
            return "BeaufortforLOL-BoldItalic"
        case .beaufortforLolMediumItalic:
            return "BeaufortforLOL-MediumItalic"
        case .beaufortforLolRegular:
            return "BeaufortforLOL-Regular"
        case .beaufortforLolHeavyItalic:
            return "BeaufortforLOL-HeavyItalic"
        case .beaufortforLolHeavy:
            return "BeaufortforLOL-Heavy"
        case .beaufortforLolBold:
            return "BeaufortforLOL-Bold"
        case .beaufortforLolLight:
            return "BeaufortforLOL-Light"
        case .beaufortforLolItalic:
            return "BeaufortforLOL-Italic"
        }
    }

    var fontName: String {
        switch self {
        case .spiegelBoldItalic:
            return "Spiegel-BoldItalic"
        case .spiegelBold:
            return "Spiegel-Bold"
        case .spiegelRegularItalic:
            return "Spiegel-RegularItalic"
        case .spiegelSemiBold:
            return "Spiegel-SemiBold"
        case .spiegelSemiBoldItalic:
            return "Spiegel-SemiBoldItalic"
        case .spiegelRegular:
            return "Spiegel-Regular"
        case .beaufortforLolMedium:
            return "BeaufortforLOL-Medium"
        case .beaufortforLolLightItalic:
            return "BeaufortforLOL-LightItalic"
        case .beaufortforLolBoldItalic:
            return "BeaufortforLOL-BoldItalic"
        case .beaufortforLolMediumItalic:
            return "BeaufortforLOL-MediumItalic"
        case .beaufortforLolRegular:
            return "BeaufortforLOL-Regular"
        case .beaufortforLolHeavyItalic:
            return "BeaufortforLOL-HeavyItalic"
        case .beaufortforLolHeavy:
            return "BeaufortforLOL-Heavy"
        case .beaufortforLolBold:
            return "BeaufortforLOL-Bold"
        case .beaufortforLolLight:
            return "BeaufortforLOL-Light"
        case .beaufortforLolItalic:
            return "BeaufortforLOL-Italic"
        }
    }

    public func withSize(_ size: CGFloat) -> Font {
        switch self {
        case .spiegelBoldItalic,
                .spiegelBold,
                .spiegelRegularItalic,
                .spiegelSemiBold,
                .spiegelSemiBoldItalic,
                .spiegelRegular,
                .beaufortforLolMedium,
                .beaufortforLolBoldItalic,
                .beaufortforLolMediumItalic,
                .beaufortforLolRegular,
                .beaufortforLolHeavyItalic,
                .beaufortforLolLightItalic,
                .beaufortforLolHeavy,
                .beaufortforLolBold,
                .beaufortforLolLight,
                .beaufortforLolItalic:
            return .custom(fontName, size: size)
        }
    }

    public static func registerFontsIfNeeded() {
        for font in allCases.compactMap({ $0.fileName }) {
            guard let url = Bundle.main.url(forResource: font, withExtension: "otf") else {
                return
            }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
