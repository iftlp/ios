//
//  LoadingView.swift
//  Shizima
//
//  Created by Loris Perret on 19/03/2025.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Body

    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(R.color.background)
    }
}

#if DEBUG
#Preview {
    LoadingView()
}
#endif
