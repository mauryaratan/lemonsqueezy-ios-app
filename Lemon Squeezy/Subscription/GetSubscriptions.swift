//
//  GetSubscriptions.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetSubscriptions: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var subscriptions: [Subscription]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getSubscriptions()
                            withAnimation {
                                subscriptions = result.data
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
                    Text("Get subscriptions")
                }
            }
            
            if let subscriptions {
                Section {
                    ForEach(subscriptions) { subscription in
                        NavigationLink {
                            GetSubscription(subscription: subscription)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(subscription.attributes.productName)
                                    Text(subscription.attributes.variantName)
                                }
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Subscriptions")
    }
}

struct GetSubscriptions_Previews: PreviewProvider {
    static var previews: some View {
        GetSubscriptions()
    }
}
