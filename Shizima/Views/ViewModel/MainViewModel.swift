//
//  MainViewModel.swift
//  Shizima
//
//  Created by Loris Perret on 07/05/2025.
//

import Foundation
import SwiftData

class MainViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published var state: SKLoadingState<Void> = .loading
    
    // MARK: - Methods

    @MainActor
    func loadData(modelContext: ModelContext) async {
        HistoryAPI.getHistory { [weak self] result in
            switch result {
            case .success(let data):
                print("✅ Succès :", data)
                
                try? modelContext.delete(model: History.self)
                
                for eachItem in data {
                    if let itemToStore = History(item: eachItem, with: modelContext) {
                        modelContext.insert(itemToStore)
                    }
                }
                
                try? modelContext.save()
                DispatchQueue.main.async {
                    self?.state = .loaded(())
                }
            case .failure(let error):
                print("❌ Échec :", error.localizedDescription)
                
                DispatchQueue.main.sync {
                    self?.state = .failed(error)
                }
            }
        }
    }
}
