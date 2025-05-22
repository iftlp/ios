//
//  ButtonStyle.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation
import SwiftUI

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var fill: PrimaryButtonStyle { PrimaryButtonStyle(outline: false, colorState: .primary) }
    static var outline: PrimaryButtonStyle { PrimaryButtonStyle(outline: true, colorState: .white) }
}

enum PrimaryButtonStyleColorState {
    case primary
    case white
    
    var textColor: Color {
        switch self {
        case .primary:
            return R.color.white
        case .white:
            return R.color.primary
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return R.color.primary
        case .white:
            return R.color.white
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    
    let outline: Bool
    let colorState: PrimaryButtonStyleColorState
    
    // MARK: - Body
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(colorState.textColor)
            .customFont(size: 17, weight: .bold)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background {
                if outline {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorState.backgroundColor)
                        .strokeBorder(colorState.textColor, lineWidth: 1)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorState.backgroundColor)
                }
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
