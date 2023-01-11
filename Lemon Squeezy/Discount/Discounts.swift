//
//  Discounts.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct Discounts: View {
    var body: some View {
        Form {
            Section("Get Discounts") {
                NavigationLink(destination: GetDiscounts()) { MethodRow(label: "`getDiscounts()`", method: .GET) }
                NavigationLink(destination: GetDiscount()) { MethodRow(label: "`getDiscount(_ discountId)`", method: .GET) }
            }
        }
        .navigationTitle("Discounts")
    }
}

struct Discounts_Previews: PreviewProvider {
    static var previews: some View {
        Discounts()
    }
}
