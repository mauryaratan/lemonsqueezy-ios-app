//
//  GetSubscriptionItemCurrentUsage.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetSubscriptionItemCurrentUsage: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var subscriptionMeta: SubscriptionItem.Meta?
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
                            let result = try await lemon.getSubscriptionItemCurrentUsage(subscriptionItemId)
                            withAnimation {
                                subscriptionMeta = result.meta
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
                    Text("Get Subscription Item Current Usage")
                }
                .disabled(subscriptionItemId.isEmpty)
            }
            
            if let subscriptionMeta {
                Section("Subscription Item Current usage") {
                    LabeledContent("Quantity", value: String(subscriptionMeta.quantity))
                    LabeledContent("Period start", value: String(subscriptionMeta.periodStart))
                    LabeledContent("Period end", value: String(subscriptionMeta.periodEnd))
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
        .navigationTitle("Get Subscription Item Current Usage")
    }
}

#Preview {
    GetSubscriptionItemCurrentUsage()
}
