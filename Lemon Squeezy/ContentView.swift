//
//  ContentView.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section { } footer: {
                  Text("This simple SwiftUI app showcases the various capabilities of the Lemon Squeezy library. Navigate into each category to explore the library methods.")
                }

                Section("Examples") {
                    NavigationLink(destination: Users()) { Label("Users", systemImage: "person") }
                }
            }
            .navigationTitle("Lemon Squeezy Example App")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
