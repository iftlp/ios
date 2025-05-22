//
//  ScanView.swift
//  Shizima
//
//  Created by Loris Perret on 19/03/2025.
//

import SwiftUI
import SwiftData

struct ScanView<ViewModel>: View where ViewModel: ScanViewModel {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @StateObject private var audioCaptureManager = AudioCaptureManager.shared
    @StateObject private var navManager = NavigationManager.shared
    @StateObject private var viewModel: ViewModel
    @State private var scannedSong: Song?
    @State private var isPresentingSheet: Bool = false
    
    // MARK: - Init
    
    init(viewModel: @autoclosure @escaping () -> ViewModel = ScanViewModel()) {
        self._viewModel = StateObject(
            wrappedValue: viewModel()
        )
    }
    
    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navManager.scanPath) {
            VStack(spacing: 32) {
                ScanAnimationView(isAnimating: $audioCaptureManager.isScanning) {
                    if audioCaptureManager.isScanning {
                        viewModel.stopScan()
                        return
                    }
                    
                    viewModel.scan(with: modelContext) { history in
                        if let history, let song = history.song {
                            scannedSong = song
                            
                            isPresentingSheet = true
                            
                            modelContext.insert(history)
                            try? modelContext.save()
                            
                            DispatchQueue.main.sync {
                                viewModel.getHistory(from: modelContext)
                            }
                        }
                    }
                }
                
                lastSearch
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(R.color.background)
            .adaptiveSheet(isPresent: $isPresentingSheet) {
                if let song = scannedSong {
                    MusicInfoSheet(item: song)
                }
            }
            .navigationDestination(for: NavigationManager.Route.self) {
                $0.view(lastNavigationPath: $navManager.scanPath)
            }
            .onChange(of: navManager.scanPath) {
                if isPresentingSheet {
                    isPresentingSheet.toggle()
                }
            }
            .onAppear {
                viewModel.getHistory(from: modelContext)
            }
            .onDisappear {
                viewModel.stopScan()
            }
            .alert("An error occurred", isPresented: $viewModel.hasScanningError, actions: {
                Button("OK") {
                    viewModel.hasScanningError.toggle()
                }
            }, message: {
                if let subtitle = viewModel.scanningError?.localizedDescription {
                    Text(subtitle)
                }
            })
            .alert("Microphone is required for scanning", isPresented: $audioCaptureManager.isGrantedPermission) {
                Button("OK") {
                    audioCaptureManager.isGrantedPermission.toggle()
                }
            }
            .navigationBarTitle(audioCaptureManager.isScanning ? "Identifying your music" : "Shizima")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Subviews

    private var lastSearch: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .bottom) {
                Text("Your recent searches")
                    .customFont(size: 16, weight: .bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    AppState.shared.selectedTab = .history
                } label: {
                    Text("See more")
                }
                .buttonStyle(.plain)
                .customFont(size: 13, weight: .regular)
            }
            .padding(.horizontal, 29)
            
            switch viewModel.lastSearchState {
            case .loading: LoadingView()
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getHistory(from: modelContext)
                }
            case .loaded(let history):
                if history.isEmpty {
                    emptyLastSearch
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(history) { item in
                                HistoryItem(item: item)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(.leading, 32)
                    .scrollTargetBehavior(.viewAligned)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 30)
    }
    
    private var emptyLastSearch: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(0..<5) { _ in
                    RoundedRectangle(cornerRadius: 30)
                        .fill(R.color.lightGrey)
                        .frame(width: 147, height: 185)
                        .opacity(0.4)
                }
            }
        }
        .padding(.leading, 32)
        .disabled(true)
    }
}

#Preview {
    ScanView(viewModel: MockScanViewModel())
}
