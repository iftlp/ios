//
//  AppState.swift
//  Shizima
//
//  Created by Loris Perret on 06/05/2025.
//

import SwiftUI

class AppState: ObservableObject {
    
    // MARK: - Singleton

    static let shared = AppState()
    
    private init() {}
    
    // MARK: - Properties

    @Published var selectedTab: TabBarItemEnum = .home
}
