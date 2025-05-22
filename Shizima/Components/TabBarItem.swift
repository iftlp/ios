//
//  TabBarItem.swift
//  Shizima
//
//  Created by Loris Perret on 19/03/2025.
//

import SwiftUI

enum TabBarItemEnum: Int, CaseIterable {
    case home
    case history
    
    var icon: Image {
        switch self {
        case .home:
            R.image.home
        case .history:
            R.image.history
        }
    }
    
    var iconSelected: Image {
        switch self {
        case .home:
            R.image.homeSelected
        case .history:
            R.image.historySelected
        }
    }
}

struct TabBarItem: View {
    
    // MARK: - Properties

    var isSelected: Bool
    var item: TabBarItemEnum
    var animationNamespace: Namespace.ID
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: 19) {
            if isSelected {
                Capsule()
                    .frame(width: 28, height: 8)
                    .foregroundStyle(R.color.primary)
                    .clipShape(HalfCapsule())
                    .offset(x: 0, y: -4)
                    .matchedGeometryEffect(id: "tabIndicator", in: animationNamespace)
            }
            
            iconView
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
    }
    
    // MARK: - Subviews

    private var iconView: some View {
        Group {
            if isSelected {
                item.iconSelected
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 28)
                    .foregroundStyle(R.color.primary)
            } else {
                item.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 28)
                    .foregroundStyle(R.color.grey)
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var animationNamespace
    
    HStack {
        TabBarItem(
            isSelected: true,
            item: .home,
            animationNamespace: animationNamespace
        )
        
        TabBarItem(
            isSelected: false,
            item: .history,
            animationNamespace: animationNamespace
        )
    }
}
