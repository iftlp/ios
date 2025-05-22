//
//  Album.swift
//  Shizima
//
//  Created by Loris Perret on 21/03/2025.
//

import SwiftData

@Model
class Album: Identifiable, Equatable {
    
    @Attribute(.unique) var id: Int?
    var title: String
    var cover: String
    var artist: Artist?
    @Relationship(deleteRule: .nullify, inverse: \Song.album) var songs: [Song] = []
    
    init(id: Int, title: String, cover: String, artist: Artist?, songs: [Song]) {
        self.id = id
        self.title = title
        self.cover = cover
        self.artist = artist
        self.songs = songs
    }
    
    init(item: AlbumDTO) {
        self.id = item.id
        self.title = item.title
        self.cover = item.cover
        self.artist = nil
        self.songs = []
    }
}
