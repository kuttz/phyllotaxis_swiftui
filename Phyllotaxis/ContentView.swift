//
//  ContentView.swift
//  Phyllotaxis
//
//  Created by Sreekuttan D on 11/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model: PhyllotaxisModel
    
    @State var changeAngle: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .gesture(
                    MagnificationGesture()
                        .onChanged({ amount in
                            changeAngle = amount - 1
                            print(amount - 1)
                        })
                        .onEnded({ amount in
                            model.angle += changeAngle
                            changeAngle = 0
                        })
                )
                .onTapGesture {
                    model.changeShape()
                }
            GeometryReader { geometry in
                Path { p in
                    for n in 0..<1000 {
                        let dn = Double(n)
                        let a = dn * (model.angle + changeAngle)
                        let r = (model.c) * sqrt(dn)
                        let x = r * cos(a) + geometry.size.width/2
                        let y = r * sin(a) + geometry.size.height/2
                        let pt = CGPoint(x: x, y: y)
                        
                        // selected shape
                        switch model.shape {
                        case .circle:
                            self.drawCircle(in: &p, at: pt, radius: CGFloat(n*10/1000))
                        case .star:
                            self.drawStar(in: &p, at: pt, radius: CGFloat(n*10/1000))
                        }
                    }
                }
                .fill(
                        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                    )
                }
                .padding()
        }
    }
    
    func drawCircle(in path: inout Path, at point: CGPoint, radius: CGFloat) {
        path.move(to: CGPoint(x: point.x + radius, y: point.y))
        path.addArc(center: point, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
    }
    
    func drawStar(in path: inout Path, at point: CGPoint, radius: CGFloat) {
            path.move(to: CGPoint(x: point.x + radius * CGFloat(cos(Angle(degrees: 342).radians)),
                                  y: point.y + radius * CGFloat(sin(Angle(degrees: 342).radians))))
            path.addLine(to: CGPoint(x: point.x + radius * CGFloat(cos(Angle(degrees: 126).radians)),
                                  y: point.y + radius * CGFloat(sin(Angle(degrees: 126).radians))))
            path.addLine(to: CGPoint(x: point.x + radius * CGFloat(cos(Angle(degrees: 270).radians)),
                                  y: point.y + radius * CGFloat(sin(Angle(degrees: 270).radians))))
            path.addLine(to: CGPoint(x: point.x + radius * CGFloat(cos(Angle(degrees: 54).radians)),
                                  y: point.y + radius * CGFloat(sin(Angle(degrees: 54).radians))))
            path.addLine(to: CGPoint(x: point.x + radius * CGFloat(cos(Angle(degrees: 198).radians)),
                                  y: point.y + radius * CGFloat(sin(Angle(degrees: 198).radians))))
            path.closeSubpath()
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: PhyllotaxisModel())
    }
}
