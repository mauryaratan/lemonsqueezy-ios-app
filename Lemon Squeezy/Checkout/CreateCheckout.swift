//
//  CreateCheckout.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct CreateCheckout: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var checkout: Checkout?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let body = [
                                "data": [
                                    "type": "checkouts",
                                    "attributes": [
                                        "custom_price": 1499
                                    ],
                                    "relationships": [
                                        "store": [
                                            "data": [
                                                "type": "stores",
                                                "id": "13"
                                            ]
                                        ],
                                        "variant": [
                                            "data": [
                                                "type": "variants",
                                                "id": "3"
                                            ]
                                        ]
                                    ],
                                ]
                            ]
                            let result = try await lemon.createCheckout(body: body)
                            withAnimation {
                                checkout = result.data
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
                    Text("Create Checkout")
                }
            }
            
            if let checkout {
                Section("Checkout") {
                    LabeledContent("Store ID", value: String(checkout.attributes.storeId))
                    LabeledContent("Variant ID", value: String(checkout.attributes.variantId))
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
        .navigationTitle("Create Checkout")
    }
}

struct CreateCheckout_Previews: PreviewProvider {
    static var previews: some View {
        CreateCheckout()
    }
}
