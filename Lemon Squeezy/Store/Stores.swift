//
//  Stores.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI

struct Stores: View {
    var body: some View {
        Form {
            Section("Stores") {
                NavigationLink(destination: GetStores()) { MethodRow(label: "`getStores()`", method: .GET) }
                NavigationLink(destination: GetStore()) { MethodRow(label: "`getStore(_ storeId)`", method: .GET) }
            }
        }
        .navigationTitle("Stores")
    }
}

struct Stores_Previews: PreviewProvider {
    static var previews: some View {
        Stores()
    }
}
