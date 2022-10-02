//
//  Font+CustomFonts.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

extension Font {
    static func mainFont(size: CGFloat, weight: Font.Weight = .light) -> Font {
        var fontName = ""
        switch weight {
        case .bold:
            fontName = "Gilroy-ExtraBold"
        default:
            fontName = "Gilroy-Light"
        }
        return .custom(fontName, size: size)
    }
}
