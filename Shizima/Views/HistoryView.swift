//
//  HistoryView.swift
//  Shizima
//
//  Created by Loris Perret on 19/03/2025.
//

import SwiftUI

struct HistoryView<ViewModel>: View where ViewModel: HistoryViewModel {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var navManager = NavigationManager.shared
    @StateObject private var viewModel: ViewModel
    @State private var items: [History] = []
    @State private var allItems: [History] = []
    @State private var searchText: String = ""
    @State private var isSearchPresented = false
    
    // MARK: - Init
    
    init(viewModel: @autoclosure @escaping () -> ViewModel = HistoryViewModel()) {
        self._viewModel = StateObject(
            wrappedValue: viewModel()
        )
    }
    
    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navManager.historyPath) {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getHistory(from: modelContext)
                }
            case .loaded(let value):
                content
                    .navigationDestination(for: NavigationManager.Route.self) {
                        $0.view(lastNavigationPath: $navManager.historyPath)
                    }
                    .onAppear {
                        items = value
                        allItems = value
                    }
            }
        }
        .onAppear {
            viewModel.getHistory(from: modelContext)
        }
    }
    
    private var content: some View {
        VStack {
            List {
                if allItems.isEmpty {
                    Text("Start by scanning a music.")
                        .customFont(size: 16, weight: .medium)
                } else {
                    ForEach(items) { item in
                        if let song = item.song {
                            GenericMusicItem(
                                title: song.title,
                                subtitle: song.artists.map { $0.name }.joined(separator: ", "),
                                label: item.date.formatted(date: .numeric, time: .omitted)
                            ) {
                                NavigationManager.shared.historyPath.navigate(to: .player(song))
                            }
                            .listRowBackground(R.color.background)
                        }
                    }
                    .listRowSeparator(.hidden, edges: .all)
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, isPresented: $isSearchPresented)
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    items = allItems
                } else {
                    items = items.filter { item in
                        if let song = item.song {
                            return song.title.contains(searchText) || song.artists.contains { $0.name.contains(searchText) }
                        }
                        return false
                    }
                }
            }
            .onTapGesture {
                isSearchPresented = false
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(R.color.background)
        .navigationBarTitle("Recent searches")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HistoryView(viewModel: MockHistoryViewModel())
}
