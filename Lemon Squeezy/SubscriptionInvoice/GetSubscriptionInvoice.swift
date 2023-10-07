//
//  GetSubscriptionInvoice.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetSubscriptionInvoice: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var subscriptionInvoice: SubscriptionInvoice?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("subscriptionInvoiceId") var subscriptionInvoiceId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Subscription Invoice ID", text: $subscriptionInvoiceId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getSubscriptionInvoice(subscriptionInvoiceId)
                            withAnimation {
                                subscriptionInvoice = result.data
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
                    Text("Get Subscription Invoice")
                }
                .disabled(subscriptionInvoiceId.isEmpty)
            }
            
            if let subscriptionInvoice {
                Section("Subscription Invoice") {
                    LabeledContent("Store ID", value: String(subscriptionInvoice.attributes.storeId))
                    LabeledContent("Card brand", value: subscriptionInvoice.attributes.cardBrand)
                    LabeledContent("Card last four", value: subscriptionInvoice.attributes.cardLastFour)
                    LabeledContent("Billing reason", value: subscriptionInvoice.attributes.billingReason)
                    LabeledContent("Total", value: subscriptionInvoice.attributes.totalFormatted)
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
        .navigationTitle("Get Subscription Invoice")
    }
}

#Preview {
    GetSubscriptionInvoice()
}
