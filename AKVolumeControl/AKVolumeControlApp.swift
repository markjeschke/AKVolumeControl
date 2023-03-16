//
//  AKVolumeControlApp.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/10/23.
//

import SwiftUI

@main
struct AKVolumeControlApp: App {

    @StateObject var conductor = Conductor()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(conductor)
        }
    }
}
