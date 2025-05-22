//
//  ScanViewModel.swift
//  Shizima
//
//  Created by Loris Perret on 03/05/2025.
//

import Foundation
import SwiftUI
import SwiftData
import AVFoundation

class ScanViewModel: ObservableObject {
    
    @Published var lastSearchState: SKLoadingState<[History]> = .loading
    @Published var hasScanningError: Bool = false
    var scanningError: Error?
    
    // MARK: - Methods
    
    @MainActor
    func getHistory(from modelContext: ModelContext) {
        do {
            var descriptor = FetchDescriptor<History>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            descriptor.fetchLimit = 5

            let results = try modelContext.fetch(descriptor)
            lastSearchState = .loaded(results)
        } catch {
            print("Fetch failed")
            lastSearchState = .failed(error)
        }
    }
    
    func scan(with modelContext: ModelContext, completion: @escaping (History?) -> Void) {
        AudioCaptureManager.shared.startRecording { [weak self] url in
            Task {
                ScanAPI.scan(url) { result in
                    switch result {
                    case .success(let data):
                        print("✅ Succès :", data)
                        completion(History(item: data, with: modelContext))
                    case .failure(let error):
                        print("❌ Échec :", error.localizedDescription)
                        
                        DispatchQueue.main.sync {
                            self?.hasScanningError = true
                            self?.scanningError = error
                        }
                    }
                }
            }
        }
    }
    
    func stopScan() {
        AudioCaptureManager.shared.stopRecording(extract: false)
    }
}
