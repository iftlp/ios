//
//  ShizimaApp.swift
//  Shizima
//
//  Created by Loris Perret on 14/03/2025.
//

import SwiftUI
import SwiftData

@main
struct ShizimaApp: App {

    // MARK: - Properties

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let container: ModelContainer
    
    // MARK: - Init

    init() {
        do {
            container = try ModelContainer(for: History.self)
        } catch {
            fatalError("Failed to create ModelContainer for History.")
        }
    }
    
    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            ZStack {
                R.color.background
                    .ignoresSafeArea(edges: .top)
                
                MainView()
            }
            .preferredColorScheme(.light)
        }
        .modelContainer(container)
        .environment(\.modelContext, container.mainContext)
    }
}
