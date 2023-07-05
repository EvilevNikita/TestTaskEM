//
//  Font.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 2/7/23.
//

import SwiftUI

extension Text {
    func customFont(fontName: String = "SF Pro Display", size: CGFloat = 16, weight: Font.Weight = .regular, kerning: CGFloat = 0, color: Color = .black) -> some View {
        self.font(Font.custom(fontName, size: size).weight(weight))
            .kerning(kerning)
            .foregroundColor(color)
    }
}
