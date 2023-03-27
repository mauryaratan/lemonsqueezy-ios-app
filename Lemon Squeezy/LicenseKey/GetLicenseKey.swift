//
//  GetLicenseKey.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetLicenseKey: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var licenseKey: LicenseKey?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("licenseKeyId") var licenseKeyId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("License Key ID", text: $licenseKeyId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getLicenseKey(licenseKeyId)
                            withAnimation {
                                licenseKey = result.data
                                errors = result.errors ?? []
                            }
                            print(result)
                        } catch {
                            if let error = error as? LemonSqueezyAPIError {
                                withAnimation{ errors = [error] }
                                print(error)
                            } else {
                                print(error.localizedDescription)
                            }
                        }
                    }
                } label: {
                    Text("Get License Key")
                }
                .disabled(licenseKeyId.isEmpty)
            }
            
            if let licenseKey {
                Section("License Key") {
                    LabeledContent("License Key", value: licenseKey.attributes.key)
                    LabeledContent("License Key - Short", value: licenseKey.attributes.keyShort)
                    LabeledContent("Status", value: licenseKey.attributes.statusFormatted)
                    LabeledContent("User name", value: licenseKey.attributes.userName)
                    LabeledContent("User email", value: licenseKey.attributes.userEmail)
                }
            }
            
            if !errors.isEmpty {
              Section("Errors") {
                ForEach(errors, id: \.self) { error in
                    Text(String(describing: error.localizedDescription))
                }
              }
            }
        }
        .navigationTitle("Get License Key")
    }
}

struct GetLicenseKey_Previews: PreviewProvider {
    static var previews: some View {
        GetLicenseKey()
    }
}
