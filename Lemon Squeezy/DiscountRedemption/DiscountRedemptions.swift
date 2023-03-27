//
//  DiscountRedemptions.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 28/03/23.
//

import SwiftUI
import LemonSqueezy

struct DiscountRedemptions: View {
    var body: some View {
        Form {
            Section("Get Discounts Redemptions") {
                NavigationLink(destination: GetDiscountRedemptions()) { MethodRow(label: "`getDiscountRedemptions()`", method: .GET) }
                NavigationLink(destination: GetDiscountRedemption()) { MethodRow(label: "`getDiscountRedemption(_ discountRedemptionId)`", method: .GET) }
            }
        }
        .navigationTitle("Discount Redemptions")
    }
}

struct DiscountRedemptions_Previews: PreviewProvider {
    static var previews: some View {
        DiscountRedemptions()
    }
}
 
