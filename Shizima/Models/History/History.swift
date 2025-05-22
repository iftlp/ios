//
//  History.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation
import SwiftData

@Model
class History: Identifiable {
    
    @Attribute(.unique) var id: Int?
    var song: Song?
    var date: Date
    
    init(id: Int, song: Song? = nil, date: Date) {
        self.id = id
        self.song = song
        self.date = date
    }
    
    convenience init?(item: HistoryDTO, with modelContext: ModelContext) {
        let song = Song(item: item.music)
//        modelContext.insert(song)
        
        if let artist = item.music.album.artist {
            let albumArtist: Artist = Artist(item: artist)
//            modelContext.insert(albumArtist)
            
            let album = Album(item: item.music.album)
//            modelContext.insert(album)
            
            album.artist = albumArtist
            albumArtist.albums.append(album)
            
            song.album = album
            album.songs.append(song)
        }
        
        let songArtists: [Artist] = item.music.artists.map { Artist(item: $0) }
//        songArtists.forEach { modelContext.insert($0) }
        
        song.artists = songArtists
        songArtists.forEach { $0.songs.append(song) }
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = formatter.date(from: item.recognitionDate)
        
        guard let date else {
            return nil
        }
        
        self.init(
            id: item.id,
            song: song,
            date: date
        )
        
        song.histories?.append(self)
    }
}
