//
//  GetLicenseKeyInstance.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetLicenseKeyInstance: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var licenseKeyInstance: LicenseKeyInstance?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("licenseKeyInstanceId") var licenseKeyInstanceId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("License Key Instance ID", text: $licenseKeyInstanceId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getLicenseKeyInstance(licenseKeyInstanceId)
                            withAnimation {
                                licenseKeyInstance = result.data
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
                    Text("Get License Key Instance")
                }
                .disabled(licenseKeyInstanceId.isEmpty)
            }
            
            if let licenseKeyInstance {
                Section("License Key Instance") {
                    LabeledContent("License key id", value: String(licenseKeyInstance.attributes.licenseKeyId))
                    LabeledContent("Instance name", value: licenseKeyInstance.attributes.name)
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
        .navigationTitle("Get License Key Instance")
    }
}

struct GetLicenseKeyInstance_Previews: PreviewProvider {
    static var previews: some View {
        GetLicenseKeyInstance()
    }
}
