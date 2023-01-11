//
//  Checkouts.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct Checkouts: View {
    var body: some View {
        Form {
            Section("Get Checkouts") {
                NavigationLink(destination: GetCheckouts()) { MethodRow(label: "`getCheckouts()`", method: .GET) }
                NavigationLink(destination: GetCheckout()) { MethodRow(label: "`getCheckout(_ checkoutId)`", method: .GET) }
                NavigationLink(destination: CreateCheckout()) { MethodRow(label: "`createCheckout(_ checkoutId)`", method: .POST) }
            }
        }
        .navigationTitle("Checkouts")
    }
}

struct Checkouts_Previews: PreviewProvider {
    static var previews: some View {
        Checkouts()
    }
}
