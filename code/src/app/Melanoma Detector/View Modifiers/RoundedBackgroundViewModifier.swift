//
//  RoundedBackgroundViewModifier.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI

struct RoundedBackgroundViewModifier: ViewModifier {
    var color: Color
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(color)
            )
    }
}

extension View {
    func roundedBackground(color: Color = .white, cornerRadius: CGFloat = 20.0) -> some View {
        ModifiedContent(content: self, modifier: RoundedBackgroundViewModifier(color: color, cornerRadius: cornerRadius))
    }
}
