//
//  TabBar.swift
//  Shizima
//
//  Created by Loris Perret on 19/03/2025.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    
    // MARK: - Properties

    @StateObject private var appState = AppState.shared
    @Namespace private var animationNamespace

    // MARK: - Body

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            ScanView()
                .tag(TabBarItemEnum.home)

            HistoryView()
                .tag(TabBarItemEnum.history)
        }
        .overlay(alignment: .bottom) {
            HStack(alignment: .bottom) {
                ForEach(TabBarItemEnum.allCases, id: \.rawValue) { item in
                    TabBarItem(
                        isSelected: appState.selectedTab == item,
                        item: item,
                        animationNamespace: animationNamespace
                    )
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.3)) {
                            appState.selectedTab = item
                        }
                    }
                }
            }
            .background(R.color.white)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    TabBar()
}
