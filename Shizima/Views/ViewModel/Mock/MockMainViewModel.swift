//
//  MockMainViewModel.swift
//  Shizima
//
//  Created by Loris Perret on 07/05/2025.
//

import Foundation
import SwiftData

class MockMainViewModel: MainViewModel {
    
    // MARK: - Methods

    override func loadData(modelContext: ModelContext) async {
        for i in 0..<10 {
            let artist = Artist(id: i, name: "\(i)", songs: [], albums: [])
            modelContext.insert(artist)
            let album = Album(id: i, title: "\(i)", cover: "mock/image.jpg", artist: nil, songs: [])
            modelContext.insert(album)
            album.artist = artist
            artist.albums.append(album)
            
            let song = Song(id: i, title: "\(i)", artists: [], album: nil, data: "mock/music.mp3", durationInSec: 123)
            modelContext.insert(song)
            song.album = album
            album.songs.append(song)
            
            song.artists.append(artist)
            artist.songs.append(song)
            
            let itemToStore = History(id: i, date: .now)
            modelContext.insert(itemToStore)
            itemToStore.song = song
            song.histories?.append(itemToStore)
            
            try? modelContext.save()
        }
        
        sleep(2)
        
        state = .loaded(())
    }
}
