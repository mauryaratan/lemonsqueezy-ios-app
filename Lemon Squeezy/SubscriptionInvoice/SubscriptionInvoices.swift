//
//  SubscriptionInvoices.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI

struct SubscriptionInvoices: View {
    var body: some View {
        Form {
            Section("Get subscription invoices") {
                NavigationLink(destination: GetSubscriptionInvoices()) { MethodRow(label: "`getSubscriptionInvoices()`", method: .GET) }
                NavigationLink(destination: GetSubscriptionInvoice()) { MethodRow(label: "`getSubscriptionInvoice()`", method: .GET) }
            }
        }
        .navigationTitle("Subscription invoices")
    }
}

#Preview {
    SubscriptionInvoices()
}
