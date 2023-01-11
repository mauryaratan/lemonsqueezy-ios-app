//
//  Subscriptions.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct Subscriptions: View {
    var body: some View {
        Form {
            Section("Get subscriptions") {
                NavigationLink(destination: GetSubscriptions()) { MethodRow(label: "`getSubscriptions()`", method: .GET) }
                NavigationLink(destination: GetSubscription()) { MethodRow(label: "`getSubscription(_ subscriptionId)`", method: .GET) }
                NavigationLink(destination: UpdateSubscription()) { MethodRow(label: "`updateSubscription(_ subscriptionId)`", method: .PATCH) }
                NavigationLink(destination: CancelSubscription()) { MethodRow(label: "`cancelSubscription(_ subscriptionId)`", method: .DELETE) }
            }
        }
        .navigationTitle("Subscriptions")
    }
}

struct Subscriptions_Previews: PreviewProvider {
    static var previews: some View {
        Subscriptions()
    }
}
