//
//  History+Mock.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

extension History {
    
    enum Mock {
        
        static func preview(id: Int = 0) -> History {
            History(id: id, song: Song.Mock.previewWithAlbum(id: id), date: .now)
        }
    }
}
