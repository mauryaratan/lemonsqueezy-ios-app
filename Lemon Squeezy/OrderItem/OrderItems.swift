//
//  OrderItems.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct OrderItems: View {
    var body: some View {
        Form {
            Section("Order Items") {
                NavigationLink(destination: GetOrderItems()) { MethodRow(label: "`getOrderItems()`", method: .GET) }
                NavigationLink(destination: GetOrderItem()) { MethodRow(label: "`getOrderItem(_ orderItemId)`", method: .GET) }
            }
        }
        .navigationTitle("Order Items")
    }
}

struct OrderItems_Previews: PreviewProvider {
    static var previews: some View {
        OrderItems()
    }
}
