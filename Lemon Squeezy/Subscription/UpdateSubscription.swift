//
//  UpdateSubscription.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct UpdateSubscription: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var subscription: Subscription?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("subscriptionId") var subscriptionId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Subscription ID", text: $subscriptionId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let body = [
                                "data": [
                                    "type": "subscriptions",
                                    "id": subscriptionId,
                                    "attributes": [
                                        "billing_anchor": 21
                                    ]
                                ]
                            ]
                            let result = try await lemon.updateSubscription(subscriptionId, body: body)
                            withAnimation {
                                subscription = result.data
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
                    Text("Update Subscription")
                }
                .disabled(subscriptionId.isEmpty)
            } footer: {
                Text("Changes billing anchor to 21")
            }
            
            if let subscription {
                Section("Subscription") {
                    LabeledContent("Product Name", value: subscription.attributes.productName)
                    LabeledContent("Variant Name", value: subscription.attributes.variantName)
                    LabeledContent("Status", value: subscription.attributes.statusFormatted)
                    LabeledContent("Billing Anchor", value: String(subscription.attributes.billingAnchor))
                    Link("Update Payment Method", destination: URL(string: subscription.attributes.urls.updatePaymentMethod)!)
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
        .navigationTitle("Update Subscription")
    }
}

struct UpdateSubscription_Previews: PreviewProvider {
    static var previews: some View {
        UpdateSubscription()
    }
}
