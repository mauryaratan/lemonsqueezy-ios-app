//
//  GetSubscription.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetSubscription: View {
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
                            let result = try await lemon.getSubscription(subscriptionId)
                            withAnimation {
                                subscription = result.data
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
                    Text("Get Subscription")
                }
                .disabled(subscriptionId.isEmpty)
            }
            
            if let subscription {
                Section("Subscription") {
                    LabeledContent("Product Name", value: subscription.attributes.productName)
                    LabeledContent("Variant Name", value: subscription.attributes.variantName)
                    LabeledContent("Status", value: subscription.attributes.statusFormatted)
                    LabeledContent("Card Brand", value: subscription.attributes.cardBrand)
                    LabeledContent("Card Last Four", value: subscription.attributes.cardLastFour)
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
        .navigationTitle("Get Subscription")
    }
}

struct GetSubscription_Previews: PreviewProvider {
    static var previews: some View {
        GetSubscription()
    }
}
