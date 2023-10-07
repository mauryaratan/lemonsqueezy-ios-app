//
//  GetUsageRecord.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetUsageRecord: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var usageRecord: UsageRecord?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("usageRecordId") var usageRecordId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Usage Record ID", text: $usageRecordId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getUsageRecord(usageRecordId)
                            withAnimation {
                                usageRecord = result.data
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
                    Text("Get Usage Record")
                }
                .disabled(usageRecordId.isEmpty)
            }
            
            if let usageRecord {
                Section("Usage Record") {
                    LabeledContent("Action", value: usageRecord.attributes.action)
                    LabeledContent("Quantity", value: String(usageRecord.attributes.quantity))
                    LabeledContent("Subscription Item ID", value: String(usageRecord.attributes.subscriptionItemId))
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
        .navigationTitle("Get Usage Record")
    }
}

#Preview {
    GetUsageRecord()
}
