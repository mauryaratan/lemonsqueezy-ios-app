//
//  License.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 05/02/23.
//

import SwiftUI

struct License: View {
    var body: some View {
        Form {
            Section("Licensing API") {
                NavigationLink(destination: ActivateLicenseView()) { MethodRow(label: "`activateLicense()`", method: .POST) }
                NavigationLink(destination: ValidateLicenseView()) { MethodRow(label: "`validateLicense()`", method: .POST) }
                NavigationLink(destination: DeactivateLicenseView()) { MethodRow(label: "`deactivateLicense()`", method: .POST) }
            }
        }
        .navigationTitle("Licensing API")
    }
}

struct License_Previews: PreviewProvider {
    static var previews: some View {
        License()
    }
}
