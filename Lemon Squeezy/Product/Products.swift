//
//  Products.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct Products: View {
    var body: some View {
        Form {
            Section("Products") {
                NavigationLink(destination: GetProducts()) { MethodRow(label: "`getProducts()`", method: .GET) }
                NavigationLink(destination: GetProduct()) { MethodRow(label: "`getProduct(_ productId)`", method: .GET) }
            }
        }
        .navigationTitle("Products")
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        Products()
    }
}
