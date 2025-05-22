//
//  MockHistoryViewModel.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation
import SwiftData

class MockHistoryViewModel: HistoryViewModel {
    
    // MARK: - Methods
    
    override func getHistory(from modelContext: ModelContext) {
        state = .loaded([
            History.Mock.preview(id: 0),
            History.Mock.preview(id: 1),
            History.Mock.preview(id: 2),
        ])
    }
}
