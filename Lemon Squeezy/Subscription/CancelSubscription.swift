//
//  CancelSubscription.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct CancelSubscription: View {
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
                            let result = try await lemon.cancelSubscription(subscriptionId)
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
                    Text("Cancel Subscription")
                }
                .disabled(subscriptionId.isEmpty)
            } footer: {
                Text("Cancels the given subscription and returns the subscription object.")
            }
            
            if let subscription {
                Section("Subscription") {
                    LabeledContent("Product Name", value: subscription.attributes.productName)
                    LabeledContent("Variant Name", value: subscription.attributes.variantName)
                    LabeledContent("Status", value: subscription.attributes.statusFormatted)
                    LabeledContent("Cancelled", value: String(subscription.attributes.cancelled))
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
        .navigationTitle("Cancel Subscription")
    }
}

struct CancelSubscription_Previews: PreviewProvider {
    static var previews: some View {
        CancelSubscription()
    }
}
