//
//  GetWebhooks.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 08/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetWebhooks: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var webhooks: [Webhook]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getWebhooks()
                            withAnimation {
                                webhooks = result.data
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
                    Text("Get webhooks")
                }
            }
            
            if let webhooks {
                Section {
                    ForEach(webhooks) { webhook in
                        NavigationLink {
                            GetWebhook(webhook: webhook)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(webhook.attributes.url)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get webhooks")
    }
}

#Preview {
    GetWebhooks()
}
