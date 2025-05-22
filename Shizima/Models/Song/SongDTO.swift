//
//  SongDTO.swift
//  Shizima
//
//  Created by Loris Perret on 21/03/2025.
//

struct SongDTO: Identifiable, Codable, Equatable {
    
    let id: Int
    let title: String
    let filePath: String
    let durationInSec: Int
    let artists: [ArtistDTO]
    let album: AlbumDTO
}
