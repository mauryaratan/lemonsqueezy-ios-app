//
//  Files.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct Files: View {
    var body: some View {
        Form {
            Section("Files") {
                NavigationLink(destination: GetFiles()) { MethodRow(label: "`getFiles()`", method: .GET) }
                NavigationLink(destination: GetFile()) { MethodRow(label: "`getFile(_ fileId)`", method: .GET) }
            }
        }
        .navigationTitle("Files")
    }
}

struct Files_Previews: PreviewProvider {
    static var previews: some View {
        Files()
    }
}
