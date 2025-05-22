//
//  HistoryItem.swift
//  Shizima
//
//  Created by Loris Perret on 05/05/2025.
//

import SwiftUI
import Kingfisher

struct HistoryItem: View {
    
    // MARK: - Properties

    let item: History
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: 13) {
            if let song = item.song {
                ZStack(alignment: .bottomTrailing) {
                    KFImage(AwsUrl(string: song.album?.cover ?? "")?.url)
                        .placeholder {
                            NoImageView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 147, height: 185)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .onTapGesture {
                                NavigationManager.shared.scanPath.navigate(to: .player(song))
                        }
                                    
                    Button {
                        NavigationManager.shared.scanPath.navigate(to: .player(song))
                    } label: {
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(R.color.lightGrey)
                                .frame(width: 29, height: 29)
                            
                            R.image.play
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(R.color.grey)
                                .padding(.leading, 4)
                        }
                    }
                    .buttonStyle(.plain)
                    .offset(x: -10, y: 10)
                }
                
                VStack(spacing: 5) {
                    Text(song.title)
                        .customFont(size: 16, weight: .bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(song.artists.map { $0.name }.joined(separator: ", "))
                        .customFont(size: 14, weight: .regular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            }
        }
        .frame(width: 147)
    }
}

#Preview {
    HistoryItem(item: History.Mock.preview())
}
