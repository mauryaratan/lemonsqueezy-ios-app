//
//  LicenseKeyInstances.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI

struct LicenseKeyInstances: View {
    var body: some View {
        Form {
            Section("Get License Key Instances") {
                NavigationLink(destination: GetLicenseKeyInstances()) { MethodRow(label: "`getLicenseKeyInstances()`", method: .GET) }
                NavigationLink(destination: GetLicenseKeyInstance()) { MethodRow(label: "`getLicenseKeyInstance(_ licenseKeyInstanceId)`", method: .GET) }
            }
        }
        .navigationTitle("License Key Instances")
    }
}

struct LicenseKeyInstances_Previews: PreviewProvider {
    static var previews: some View {
        LicenseKeyInstances()
    }
}
