//
//  ActivateLicense.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 05/02/23.
//

import SwiftUI
import LemonSqueezy

struct ActivateLicenseView: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("licenseKey") var licenseKey = ""
    @SceneStorage("instanceName") var instanceName = ""
    @State var license: ActivateLicense?
    
    var body: some View {
        Form {
            Section {
                TextField("License Key", text: $licenseKey)
                TextField("Instance Name", text: $instanceName)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.activateLicense(licenseKey: licenseKey, instanceName: instanceName)
                            license = result.self
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
                    Text("Activate License Key")
                }
                .disabled(licenseKey.isEmpty)
            }
            
            if let license {
                Section("License") {
                    LabeledContent("License Key", value: license.licenseKey.key)
                    LabeledContent("License Instance", value: license.instance.name)
                    LabeledContent("Product Name", value: license.meta.productName)
                    LabeledContent("Variant Name", value: license.meta.variantName)
                    LabeledContent("Customer Name", value: license.meta.customerName)
                    LabeledContent("Customer Email", value: license.meta.customerEmail)
                }
            }
            
            if !errors.isEmpty {
              Section("Errors") {
                ForEach(errors, id: \.self) { error in
                    Text(error.error!)
                }
              }
            }
        }
    }
}

struct ActivateLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        ActivateLicenseView()
    }
}
