//
//  Font.swift
//  Shizima
//
//  Created by Loris Perret on 28/03/2025.
//

import Foundation
import SwiftUI

extension R2Font {
    
    enum FontName: String {
        case SpaceGrotesk = "Space Grotesk"
    }

    // MARK: - Getter

    func SpaceGrotesk(withSize size: CGFloat) -> Font {
        Font.custom(FontName.SpaceGrotesk.rawValue, size: size)
    }
}
