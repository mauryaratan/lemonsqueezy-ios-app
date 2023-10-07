//
//  SubscriptionItems.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI

struct SubscriptionItems: View {
    var body: some View {
        Form {
            Section("Get subscription items") {
                NavigationLink(destination: GetSubscriptionItems()) { MethodRow(label: "`getSubscriptionItems()`", method: .GET) }
                NavigationLink(destination: GetSubscriptionItem()) { MethodRow(label: "`getSubscriptionItem()`", method: .GET) }
                NavigationLink(destination: UpdateSubscriptionItem()) { MethodRow(label: "`updateSubscriptionItem()`", method: .PATCH) }
                NavigationLink(destination: GetSubscriptionItemCurrentUsage()) { MethodRow(label: "`getSubscriptionItemCurrentUsage()`", method: .GET) }
            }
        }
        .navigationTitle("Subscription items")
    }
}

#Preview {
    SubscriptionItems()
}
