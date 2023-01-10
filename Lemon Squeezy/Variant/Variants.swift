//
//  Variants.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct Variants: View {
    var body: some View {
        Form {
            Section("Variants") {
                NavigationLink(destination: GetVariants()) { MethodRow(label: "`getVariants()`", method: .GET) }
                NavigationLink(destination: GetVariant()) { MethodRow(label: "`getVariant(_ variantId)`", method: .GET) }
            }
        }
        .navigationTitle("Variants")
    }
}

struct Variants_Previews: PreviewProvider {
    static var previews: some View {
        Variants()
    }
}
