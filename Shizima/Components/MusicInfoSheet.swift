//
//  MusicInfoSheet.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import SwiftUI
import Kingfisher

struct MusicInfoSheet: View {
    
    // MARK: - Properties
    
    @StateObject var navManager = NavigationManager.shared

    let item: Song
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: 14) {
            Text("Music found")
                .customFont(size: 18, weight: .bold)
                .padding(.top, 20)
            
            KFImage(AwsUrl(string: item.album?.cover ?? "")?.url)
                .placeholder {
                    NoImageView()
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 226)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(spacing: 0) {
                Text(item.title)
                    .customFont(size: 20, weight: .bold)
                Text(item.artists.map { $0.name }.joined(separator: ", "))
                    .customFont(size: 18, weight: .regular)
            }
            .padding(.vertical, 4)
            
            listenButton
            artistButton
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 10)
        .background(R.color.background)
    }
    
    // MARK: - Methods
    
    private var listenButton: some View {
        Button {
            navManager.scanPath.navigate(to: .player(item))
        } label: {
            HStack {
                R.image.headphones
                Text("Listen to the music")
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.fill)
    }
    
    private var artistButton: some View {
        Button {
            if let first = item.artists.first {
                navManager.scanPath.navigate(to: .artist(first))
            }
        } label: {
            HStack {
                R.image.magnifyingGlass
                Text("See more about the artist")
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.outline)
    }
}

#Preview {
    MusicInfoSheet(item: Song.Mock.previewWithAlbum())
}
