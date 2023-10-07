//
//  GetUsageRecords.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetUsageRecords: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var usageRecords: [UsageRecord]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getUsageRecords()
                            withAnimation {
                                usageRecords = result.data
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
                    Text("Get usage records")
                }
            }
            
            if let usageRecords {
                Section {
                    ForEach(usageRecords) { usageRecord in
                        NavigationLink {
                            GetUsageRecord(usageRecord: usageRecord)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(usageRecord.attributes.action)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get usage records")
    }
}

#Preview {
    GetUsageRecords()
}
