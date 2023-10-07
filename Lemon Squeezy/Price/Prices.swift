//
//  Prices.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct Prices: View {
    @EnvironmentObject var lemon: LemonSqueezy
    
    var body: some View {
        Form {
            Section("Prices") {
                NavigationLink(destination: GetPrice()) { MethodRow(label: "`getPrice()`", method: .GET) }
                NavigationLink(destination: GetPrices()) { MethodRow(label: "`getPrices()`", method: .GET) }
            }
        }
        .navigationTitle("Prices")
    }
}

#Preview {
    Prices()
}
