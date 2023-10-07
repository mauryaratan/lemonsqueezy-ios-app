//
//  UsageRecords.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct UsageRecords: View {
    @EnvironmentObject var lemon: LemonSqueezy
    
    var body: some View {
        Form {
            Section("Usage records") {
                NavigationLink(destination: GetUsageRecord()) { MethodRow(label: "`getUsageRecord()`", method: .GET) }
                NavigationLink(destination: GetUsageRecords()) { MethodRow(label: "`getUsageRecords()`", method: .GET) }
            }
        }
        .navigationTitle("Usage records")
    }
}

#Preview {
    UsageRecords()
}
