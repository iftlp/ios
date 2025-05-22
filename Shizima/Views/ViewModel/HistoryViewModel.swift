//
//  HistoryViewModel.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation
import SwiftData

class HistoryViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published var searchText: String = ""
    @Published var state: SKLoadingState<[History]> = .loading
    
    // MARK: - Methods
    
    func getHistory(from modelContext: ModelContext) {
        do {
            let descriptor = FetchDescriptor<History>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            let results = try modelContext.fetch(descriptor)
            state = .loaded(results)
        } catch {
            print("Fetch failed")
            state = .failed(error)
        }
    }
}
