//
//  Album+Mock.swift
//  Shizima
//
//  Created by Loris Perret on 21/03/2025.
//

extension Album {
    
    enum Mock {
        
        static func preview(id: Int = 0) -> Album {
            Album(
                id: id,
                title: "Ceinture noire",
                cover: "mock/image.jpg",
                artist: Artist.Mock.empty(id: id),
                songs: [
                    Song.Mock.previewWithAlbum(id: 0),
                    Song.Mock.previewWithAlbum(id: 1)
                ]
            )
        }
        
        static func empty(id: Int = 0) -> Album {
            Album(
                id: id,
                title: "Ceinture noire",
                cover: "mock/image.jpg",
                artist: Artist.Mock.empty(id: id),
                songs: []
            )
        }
    }
}
