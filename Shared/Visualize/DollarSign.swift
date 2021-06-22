//
//  StarShape.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 6/6/21.
//

import SwiftUI

// Custom shape
struct DollarSign: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        p.move(to: center)
        
        // Verticle line
        p.addLine(to: CGPoint(x: (center.x), y: center.y * 1.55))
        p.addLine(to: CGPoint(x: (center.x), y : center.y * 0.5))
        
        // S shape
        p.move(to: CGPoint(x: center.x * 1.3, y: center.y * 0.6))
        p.addCurve(to: CGPoint(x: center.x * 0.5, y: center.y * 1.4), control1: CGPoint(x: center.x * -0.9, y: center.y * 0.8), control2: CGPoint(x: center.x * 3, y: center.y * 1.3))
        return p
    }
}

struct DollarSignView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            GeometryReader { geometry in
                ZStack {
                    Group {
                        DollarSign()
                            .stroke(moneyGreen, lineWidth: 8)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
        }
    }
}

struct DollarSignView_Previews: PreviewProvider {
    static var previews: some View {
        DollarSignView()
    }
}
