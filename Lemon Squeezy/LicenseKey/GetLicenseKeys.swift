//
//  GetLicenseKeys.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetLicenseKeys: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var licenseKeys: [LicenseKey]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getLicenseKeys()
                            withAnimation {
                                licenseKeys = result.data
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
                    Text("Get license keys")
                }
            }
            
            if let licenseKeys {
                Section {
                    ForEach(licenseKeys) { licenseKey in
                        NavigationLink {
                            GetLicenseKey(licenseKey: licenseKey)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(licenseKey.attributes.keyShort)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get license keys")
    }
}

struct GetLicenseKeys_Previews: PreviewProvider {
    static var previews: some View {
        GetLicenseKeys()
    }
}
