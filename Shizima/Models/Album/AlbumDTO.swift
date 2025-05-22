//
//  AlbumDTO.swift
//  Shizima
//
//  Created by Loris Perret on 21/03/2025.
//

struct AlbumDTO: Identifiable, Codable, Equatable {
    
    let id: Int
    let title: String
    let cover: String
    let musics: [SongDTO]?
    let artist: ArtistDTO?
}
