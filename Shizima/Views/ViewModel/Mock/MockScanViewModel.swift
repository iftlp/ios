//
//  MockScanViewModel.swift
//  Shizima
//
//  Created by Loris Perret on 03/05/2025.
//

import Foundation
import SwiftData

class MockScanViewModel: ScanViewModel {
    
    // MARK: - Methods
    
    override func getHistory(from modelContext: ModelContext) {
        lastSearchState = .loaded([
            History.Mock.preview(id: 0),
            History.Mock.preview(id: 1),
            History.Mock.preview(id: 2),
        ])
    }
}
