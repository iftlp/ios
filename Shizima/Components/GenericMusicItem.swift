//
//  GenericMusicItem.swift
//  Shizima
//
//  Created by Loris Perret on 01/04/2025.
//

import SwiftUI

struct GenericMusicItem: View {
    
    // MARK: - Properties

    @StateObject var navManager = NavigationManager.shared
        
    let title: String
    let subtitle: String
    let label: String
    let playAction: () -> Void
    
    // MARK: - Body

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                playAction()
            } label: {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(R.color.lightGrey)
                        .frame(width: 42, height: 42)
                    
                    R.image.play
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(R.color.grey)
                        .padding(.leading, 4)
                }
            }
            .buttonStyle(.plain)
            
            VStack(spacing: 7) {
                Text(title)
                    .customFont(size: 16, weight: .bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(subtitle)
                    .customFont(size: 12, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(label)
                .customFont(size: 15, weight: .regular)
        }
    }
}

#Preview {
    GenericMusicItem(
        title: "1",
        subtitle: "2",
        label: "3"
    ) {}
}
