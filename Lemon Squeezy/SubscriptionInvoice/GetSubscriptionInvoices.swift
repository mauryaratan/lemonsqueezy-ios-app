//
//  GetSubscriptionInvoices.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetSubscriptionInvoices: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var subscriptionInvoices: [SubscriptionInvoice]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getSubscriptionInvoices()
                            withAnimation {
                                subscriptionInvoices = result.data
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
                    Text("Get subscription invoices")
                }
            }
            
            if let subscriptionInvoices {
                Section {
                    ForEach(subscriptionInvoices) { subscriptionInvoice in
                        NavigationLink {
                            GetSubscriptionInvoice(subscriptionInvoice: subscriptionInvoice)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(subscriptionInvoice.attributes.userName)
                                    Text(subscriptionInvoice.attributes.userEmail)
                                }
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Subscriptions invoices")
    }
}

#Preview {
    GetSubscriptionInvoices()
}
