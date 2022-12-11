//
//  PhyllotaxisApp.swift
//  Phyllotaxis
//
//  Created by Sreekuttan D on 11/12/22.
//

import SwiftUI

@main
struct PhyllotaxisApp: App {
    
    private var model = PhyllotaxisModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
