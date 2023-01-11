//
//  GetCheckout.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetCheckout: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var checkout: Checkout?
    @State var errors: [LemonSqueezyAPIError] = []
    @State var checkoutId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Checkout ID", text: $checkoutId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getCheckout(checkoutId)
                            withAnimation {
                                checkout = result.data
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
                    Text("Get Checkout")
                }
                .disabled(checkoutId.isEmpty)
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
        .navigationTitle("Get Checkout")
    }
}

struct GetCheckout_Previews: PreviewProvider {
    static var previews: some View {
        GetCheckout()
    }
}
