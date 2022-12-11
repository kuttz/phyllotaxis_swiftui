//
//  PhyllotaxisModel.swift
//  Phyllotaxis
//
//  Created by Sreekuttan D on 11/12/22.
//

import Foundation
import UIKit

enum Shape {
    case circle
    case star
}

class PhyllotaxisModel: ObservableObject {
    
    @Published var angle: Double = 137.5
    
    @Published var shape: Shape = .circle
    
    var c: Double {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 12
        } else {
            return 5
        }
    }
    
    func changeShape() {
        shape = shape == .circle ? .star : .circle
    }
    
}
