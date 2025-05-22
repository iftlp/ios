//
//  NoImageView.swift
//  Shizima
//
//  Created by Loris Perret on 16/05/2025.
//

import SwiftUI

struct NoImageView: View {
    var body: some View {
        GeometryReader { geometry in
            R.image.noImage
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(R.color.grey)
                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(R.color.lightGrey)
        }
    }
}

#Preview {
    NoImageView()
}
