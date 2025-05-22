//
//  ArtistView.swift
//  Shizima
//
//  Created by Loris Perret on 01/04/2025.
//

import Kingfisher
import SwiftData
import SwiftUI

struct ArtistView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    let item: Artist
    @Binding var lastNavigationPath: [NavigationManager.Route]

    // MARK: - Body

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                cover
                
                if !item.albums.isEmpty {
                    albums
                }
                
                if !item.songs.isEmpty {
                    songs
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea(edges: .top)
        .background(R.color.background)
    }
    
    // MARK: - Subviews

    private var cover: some View {
        VStack(spacing: 12) {
            GeometryReader { geometry in
                KFImage(AwsUrl(string: item.albums.first?.cover ?? "")?.url)
                    .placeholder {
                        NoImageView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 240)
                    .clipShape(CustomBottomRoundedRectangle(radius: 70))
                    .clipped()
            }
            .frame(height: 240)
        
            VStack(spacing: 10) {
                Text(item.name)
                    .customFont(size: 20, weight: .bold)
                Text("\(item.albums.count) Albums, \(item.songs.count) Tracks")
                    .customFont(size: 13, weight: .regular)
            }
        }
        .frame(minHeight: 240)
    }
    
    private var albums: some View {
        VStack(alignment: .leading) {
            Text("Albums")
                .customFont(size: 16, weight: .bold)
                .padding(.leading, 29)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: 16) {
                    ForEach(item.albums) { item in
                        ArtistAlbumItem(item: item)
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.leading, 29)
            .scrollTargetBehavior(.viewAligned)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var songs: some View {
        VStack(spacing: 20) {
            Text("Songs")
                .customFont(size: 16, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                ForEach(item.songs) { item in
                    GenericMusicItem(
                        title: item.title,
                        subtitle: item.artists.map { $0.name }.joined(separator: ", "),
                        label: timeString(for: item.durationInSec)
                    ) {
                        lastNavigationPath.navigate(to: .player(item))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 29)
    }
    
    private func timeString(for seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    ArtistView(item: Artist.Mock.preview(), lastNavigationPath: .constant([]))
}
