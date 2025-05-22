//
//  ArtistAlbumItem.swift
//  Shizima
//
//  Created by Loris Perret on 01/04/2025.
//

import SwiftUI
import Kingfisher

struct ArtistAlbumItem: View {
    
    // MARK: - Properties

    let item: Album
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: 8) {
            KFImage(AwsUrl(string: item.cover)?.url)
                .placeholder {
                    NoImageView()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 135)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Text(item.title)
                .customFont(size: 14, weight: .bold)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ArtistAlbumItem(item: Album.Mock.empty())
}
