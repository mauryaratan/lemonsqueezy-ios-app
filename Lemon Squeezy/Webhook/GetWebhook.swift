//
//  GetWebhook.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 08/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetWebhook: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var webhook: Webhook?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("webhookId") var webhookId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Webhook ID", text: $webhookId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getWebhook(webhookId)
                            withAnimation {
                                webhook = result.data
                                errors = result.errors ?? []
                            }
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
                    Text("Get Webhook")
                }
                .disabled(webhookId.isEmpty)
            }
            
            if let webhook {
                Section("Webhook") {
                    LabeledContent("Store ID", value: String(webhook.attributes.storeId))
                    LabeledContent("URL", value: webhook.attributes.url)
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
        .navigationTitle("Get Webhook")
    }
}

#Preview {
    GetWebhook()
}
