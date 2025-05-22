//
//  Artist.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import SwiftData

@Model
class Artist: Identifiable, Equatable {
    
    @Attribute(.unique) var id: Int?
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Song.artists) var songs: [Song] = []
    @Relationship(deleteRule: .nullify, inverse: \Album.artist) var albums: [Album] = []
    
    init(id: Int, name: String, songs: [Song], albums: [Album]) {
        self.id = id
        self.name = name
        self.songs = songs
        self.albums = albums
    }
    
    init(item: ArtistDTO) {
        self.id = item.id
        self.name = item.name
        self.songs = []
        self.albums = []
    }
}
