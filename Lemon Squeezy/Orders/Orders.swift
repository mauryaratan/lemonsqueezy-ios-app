//
//  Orders.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI

struct Orders: View {
    var body: some View {
        Form {
            Section("Get orders") {
                NavigationLink(destination: GetOrders()) { MethodRow(label: "`getOrders()`", method: .GET) }
                NavigationLink(destination: GetOrder()) { MethodRow(label: "`getOrder(_ orderId)`", method: .GET) }
            }
        }
        .navigationTitle("Orders")
    }
}

struct Orders_Previews: PreviewProvider {
    static var previews: some View {
        Orders()
    }
}
