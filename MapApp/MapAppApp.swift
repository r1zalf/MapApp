//
//  MapAppApp.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 21/01/24.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject var vm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
