//
//  UpdateSubscriptionItem.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct UpdateSubscriptionItem: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var subscriptionItem: SubscriptionItem?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("subscriptionItemId") var subscriptionItemId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Subscription Item ID", text: $subscriptionItemId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let body = [
                                "data": [
                                    "type": "subscription-items",
                                    "id": subscriptionItemId,
                                    "attributes": [
                                        "quantity": 10
                                    ]
                                ]
                            ]
                            let result = try await lemon.updateSubscriptionItem(subscriptionItemId, body: body)
                            withAnimation {
                                subscriptionItem = result.data
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
                    Text("Update Subscription Item")
                }
                .disabled(subscriptionItemId.isEmpty)
            } footer: {
                Text("Changes quantity to 10")
            }
            
            if let subscriptionItem {
                Section("Subscription Item") {
                    LabeledContent("Quantity", value: String(subscriptionItem.attributes.quantity))
                    LabeledContent("Subscription ID", value: String(subscriptionItem.attributes.subscriptionId))
                    LabeledContent("Price ID", value: String(subscriptionItem.attributes.priceId))
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
        .navigationTitle("Update Subscription Item")
    }
}

#Preview {
    UpdateSubscriptionItem()
}
