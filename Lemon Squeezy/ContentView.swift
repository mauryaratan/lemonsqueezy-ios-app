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
                    Group {
                        NavigationLink(destination: Users()) { Label("Users", systemImage: "person") }
                        NavigationLink(destination: Orders()) { Label("Orders", systemImage: "cart") }
                        NavigationLink(destination: Stores()) { Label("Store", systemImage: "building.2") }
                        NavigationLink(destination: Products()) { Label("Products", systemImage: "archivebox") }
                        NavigationLink(destination: Variants()) { Label("Variants", systemImage: "shippingbox") }
                        NavigationLink(destination: Files()) { Label("Files", systemImage: "doc.text.image.fill") }
                        NavigationLink(destination: OrderItems()) { Label("Order Items", systemImage: "cart.badge.plus") }
                        NavigationLink(destination: Subscriptions()) { Label("Subscriptions", systemImage: "chart.bar.xaxis") }
                        NavigationLink(destination: Discounts()) { Label("Discounts", systemImage: "ticket") }
                        NavigationLink(destination: LicenseKeys()) { Label("License Keys", systemImage: "key") }
                    }
                    Group {
                        NavigationLink(destination: LicenseKeyInstances()) { Label("License Keys Instances", systemImage: "key.radiowaves.forward") }
                        NavigationLink(destination: Checkouts()) { Label("Checkouts", systemImage: "cart.fill.badge.plus") }
                    }
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
