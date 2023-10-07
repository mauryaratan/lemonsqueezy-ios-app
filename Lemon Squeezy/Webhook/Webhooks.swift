//
//  Webhooks.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 08/10/23.
//

import SwiftUI
import LemonSqueezy

struct Webhooks: View {
    @EnvironmentObject var lemon: LemonSqueezy
    
    var body: some View {
        Form {
            Section("Webhooks") {
                NavigationLink(destination: GetWebhook()) { MethodRow(label: "`getWebhook()`", method: .GET) }
                NavigationLink(destination: GetWebhooks()) { MethodRow(label: "`getWebhooks()`", method: .GET) }
            }
        }
        .navigationTitle("Webhooks")
    }
}

#Preview {
    Webhooks()
}
