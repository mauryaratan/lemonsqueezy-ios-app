//
//  Lemon_SqueezyApp.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI
import LemonSqueezy

@main
struct Lemon_SqueezyApp: App {
    @StateObject var lemon = LemonSqueezy(LS_API_KEY)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lemon)
        }
    }
}
