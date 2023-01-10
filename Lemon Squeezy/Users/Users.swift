//
//  Users.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI
import LemonSqueezy

struct Users: View {
    @EnvironmentObject var lemon: LemonSqueezy
    
    var body: some View {
        Form {
            Section("Get user") {
                NavigationLink(destination: GetMe()) { MethodRow(label: "`getMe()`", method: .GET) }
            }
        }
        .navigationTitle("Users")
    }
}

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Users()
    }
}
