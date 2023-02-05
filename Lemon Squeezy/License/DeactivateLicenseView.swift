//
//  DeactivateLicenseView.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 05/02/23.
//

import SwiftUI
import LemonSqueezy

struct DeactivateLicenseView: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("licenseKey") var licenseKey = ""
    @SceneStorage("instanceId") var instanceId = ""
    @State var license: DeactivateLicense?
    
    var body: some View {
        Form {
            Section {
                TextField("License Key", text: $licenseKey)
                TextField("Instance ID", text: $instanceId)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.deactivateLicense(queryItems: [
                                URLQueryItem(name: "license_key", value: licenseKey),
                                URLQueryItem(name: "instance_id", value: instanceId),
                            ])
                            
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
                    Text("Deactivate License Key")
                }
                .disabled(licenseKey.isEmpty || instanceId.isEmpty)
            }
            
            if let license {
                Section("License") {
                    LabeledContent("License Key", value: license.licenseKey.key)
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

struct DeactivateLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        DeactivateLicenseView()
    }
}
