//
//  Song.swift
//  Shizima
//
//  Created by Loris Perret on 21/03/2025.
//

import SwiftData

@Model
class Song: Identifiable, Equatable {
    
    @Attribute(.unique) var id: Int?
    var title: String
    var artists: [Artist] = []
    var album: Album?
    var data: String
    var durationInSec: Int
    @Relationship(deleteRule: .cascade, inverse: \History.song) var histories: [History]?
    
    init(id: Int, title: String, artists: [Artist], album: Album?, data: String, durationInSec: Int) {
        self.id = id
        self.title = title
        self.artists = artists
        self.album = album
        self.data = data
        self.durationInSec = durationInSec
    }
    
    init(item: SongDTO) {
        self.id = item.id
        self.title = item.title
        self.data = item.filePath
        self.durationInSec = item.durationInSec
    }
}
