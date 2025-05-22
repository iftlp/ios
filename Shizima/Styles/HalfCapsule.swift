//
//  HalfCapsule.swift
//  Shizima
//
//  Created by Loris Perret on 20/03/2025.
//

import SwiftUI

struct HalfCapsule: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.height / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: true
        )
        path.addRect(CGRect(x: rect.minX, y: rect.midY, width: rect.width, height: rect.height / 2))
        return path
    }
}
