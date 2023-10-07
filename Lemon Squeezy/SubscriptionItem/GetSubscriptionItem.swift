//
//  GetSubscriptionItem.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetSubscriptionItem: View {
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
                            let result = try await lemon.getSubscriptionItem(subscriptionItemId)
                            withAnimation {
                                subscriptionItem = result.data
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
                    Text("Get Subscription Item")
                }
                .disabled(subscriptionItemId.isEmpty)
            }
            
            if let subscriptionItem {
                Section("Subscription Item") {
                    LabeledContent("Subscription ID", value: String(subscriptionItem.attributes.subscriptionId))
                    LabeledContent("Price ID", value: String(subscriptionItem.attributes.priceId))
                    LabeledContent("Quantity", value: String(subscriptionItem.attributes.quantity))
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
        .navigationTitle("Get Subscription Item")
    }
}

#Preview {
    GetSubscriptionItem()
}
