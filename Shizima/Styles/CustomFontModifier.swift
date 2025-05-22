//
//  CustomFontModifier.swift
//  Shizima
//
//  Created by Loris Perret on 28/03/2025.
//

import Foundation
import SwiftUI

struct CustomFontModifier: ViewModifier {
    
    // MARK: - Properties

    let size: CGFloat
    let weight: Font.Weight

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .font(R.font.SpaceGrotesk(withSize: size))
            .fontWeight(weight)
            .foregroundStyle(R.color.black)
    }

}

extension View {
    func customFont(size: CGFloat, weight: Font.Weight) -> some View {
        self.modifier(CustomFontModifier(size: size, weight: weight))
    }
}
