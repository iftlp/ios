//
//  ErrorView.swift
//  Shizima
//
//  Created by Loris Perret on 19/03/2025.
//

import SwiftUI

struct ErrorView: View {
    
    // MARK: - Properties

    let error: Error
    let handler: () -> Void

    // MARK: - Body

    var body: some View {
        VStack {
            Text(error.localizedDescription)
            
            Button {
                handler()
            } label: {
                Text("Retry")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(28)
        .background(R.color.background)
    }
}

#if DEBUG
#Preview {
    ErrorView(error: NSError(domain: "", code: 0, userInfo: nil)) {}
}
#endif
