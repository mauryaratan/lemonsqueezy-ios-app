//
//  GetLicenseKeyInstances.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetLicenseKeyInstances: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var licenseKeyInstances: [LicenseKeyInstance]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getLicenseKeyInstances()
                            withAnimation {
                                licenseKeyInstances = result.data
                                errors = result.errors ?? []
                            }
                            print(result)
                        } catch {
                            if let error = error as? LemonSqueezyAPIError {
                                withAnimation{ errors = [error] }
                            } else {
                                print(error.localizedDescription)
                            }
                        }
                    }
                } label: {
                    Text("Get license key instances")
                }
            }
            
            if let licenseKeyInstances {
                Section {
                    ForEach(licenseKeyInstances) { licenseKeyInstance in
                        NavigationLink {
                            GetLicenseKeyInstance(licenseKeyInstance: licenseKeyInstance)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(licenseKeyInstance.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get license key instances")
    }
}

struct GetLicenseKeyInstances_Previews: PreviewProvider {
    static var previews: some View {
        GetLicenseKeyInstances()
    }
}
