//
//  LicenseKeys.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct LicenseKeys: View {
    var body: some View {
        Form {
            Section("Get License Keys") {
                NavigationLink(destination: GetLicenseKeys()) { MethodRow(label: "`getLicenseKeys()`", method: .GET) }
                NavigationLink(destination: GetLicenseKey()) { MethodRow(label: "`getLicenseKey(_ licenseKeyId)`", method: .GET) }
            }
        }
        .navigationTitle("License Keys")
    }
}

struct LicenseKeys_Previews: PreviewProvider {
    static var previews: some View {
        LicenseKeys()
    }
}
