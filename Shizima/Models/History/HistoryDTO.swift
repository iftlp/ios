//
//  HistoryDTO.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation

struct HistoryDTO: Codable {
    
    let id: Int
    let recognitionDate: String
    let music: SongDTO
}
