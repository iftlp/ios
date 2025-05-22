//
//  NaviguationManager.swift
//  Shizima
//
//  Created by Loris Perret on 04/05/2025.
//

import SwiftUI

class NavigationManager: ObservableObject {
    
    enum Route {
        case artist(Artist)
        case player(Song)
        
        @ViewBuilder
        func view(lastNavigationPath: Binding<[Route]>) -> some View {
            switch self {
            case .artist(let artist):
                ArtistView(item: artist, lastNavigationPath: lastNavigationPath)
            case .player(let song):
                PlayerView(item: song, lastNavigationPath: lastNavigationPath)
            }
        }
    }
    
    // MARK: - Singleton

    static let shared = NavigationManager()
    
    private init() {}
    
    // MARK: - Properties

    @Published var scanPath = [Route]()
    @Published var historyPath = [Route]()
}

extension NavigationManager.Route: Hashable, Equatable {
    
    static func == (lhs: NavigationManager.Route, rhs: NavigationManager.Route) -> Bool {
        switch (lhs, rhs) {
        case (.artist(let lhsA), .artist(let lrsA)):
            return lhsA == lrsA
        case (.player(let lhsP), .player(let lrsP)):
            return lhsP == lrsP
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .artist(let artist):
            hasher.combine(artist.id)
        case .player(let song):
            hasher.combine(song.id)
        }
    }
}

extension [NavigationManager.Route] {
    
    mutating func navigate(to destination: NavigationManager.Route) {
        self.append(destination)
    }
    
    @MainActor
    mutating func popToRoot() {
        self.removeAll()
    }
    
    mutating func pop() {
        self.removeLast()
    }
}
