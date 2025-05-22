//
//  Artist+Mock.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

extension Artist {
    
    enum Mock {
        
        static func preview(id: Int = 0) -> Artist {
            Artist(
                id: 0,
                name: "Gims",
                songs: [
                    Song.Mock.previewWithAlbum(id: 0),
                    Song.Mock.previewWithAlbum(id: 1),
                    Song.Mock.previewWithAlbum(id: 2)
                ],
                albums: [
                    Album.Mock.preview(id: 0),
                    Album.Mock.preview(id: 1),
                    Album.Mock.preview(id: 2)
                ]
            )
        }
        
        static func empty(id: Int = 0) -> Artist {
            Artist(
                id: id,
                name: "Gims",
                songs: [],
                albums: []
            )
        }
    }
}
