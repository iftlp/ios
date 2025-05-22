//
//  Song+Mock.swift
//  Shizima
//
//  Created by Loris Perret on 21/03/2025.
//

extension Song {
    
    enum Mock {
        
        static func previewWithAlbum(id: Int = 0) -> Song {
            Song(
                id: id,
                title: "\(id)",
                artists: [Artist.Mock.empty(id: id)],
                album: Album.Mock.empty(id: id),
                data: "mock/music.mp3",
                durationInSec: 123
            )
        }
    }
}
