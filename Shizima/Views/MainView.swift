//
//  MainView.swift
//  Shizima
//
//  Created by Loris Perret on 07/05/2025.
//

import SwiftUI
import SwiftData

struct MainView<ViewModel>: View where ViewModel: MainViewModel {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Init
    
    init(viewModel: @autoclosure @escaping () -> ViewModel = MainViewModel()) {
        self._viewModel = StateObject(
            wrappedValue: viewModel()
        )
    }

    // MARK: - Body

    var body: some View {
        switch viewModel.state {
        case .loading:
            LoadingView()
                .task {
                    await viewModel.loadData(modelContext: modelContext)
                }
        case .failed(let error):
            ErrorView(error: error) {
                Task {
                    await viewModel.loadData(modelContext: modelContext)
                }
            }
        case .loaded(_):
            TabBar()
        }
    }
}

#Preview {
    MainView(viewModel: MockMainViewModel())
}
