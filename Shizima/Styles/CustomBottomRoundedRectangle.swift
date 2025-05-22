//
//  CustomBottomRoundedRectangle.swift
//  Shizima
//
//  Created by Loris Perret on 01/04/2025.
//

import SwiftUI

struct CustomBottomRoundedRectangle: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - radius))
        path.addArc(center: CGPoint(x: bottomRight.x - radius, y: bottomRight.y - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: bottomLeft.x + radius, y: bottomLeft.y))
        path.addArc(center: CGPoint(x: bottomLeft.x + radius, y: bottomLeft.y - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.closeSubpath()
        
        return path
    }
}
