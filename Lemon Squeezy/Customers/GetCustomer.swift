//
//  GetCustomer.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 28/03/23.
//

import SwiftUI
import LemonSqueezy

struct GetCustomer: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var customer: Customer?
    @State var errors: [LemonSqueezyAPIError] = []
    @State var customerId = ""
    
    
    var body: some View {
        Form {
            Section {
                TextField("Customer ID", text: $customerId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getCustomer(customerId)
                            withAnimation {
                                customer = result.data
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
                    Text("Get Customer")
                }
                .disabled(customerId.isEmpty)
            }
            
            if let customer {
                Section("Customer") {
                    LabeledContent("Name", value: customer.attributes.name)
                    LabeledContent("Email", value: customer.attributes.email)
                    LabeledContent("Status", value: customer.attributes.statusFormatted)
                    LabeledContent("Total Revenue", value: customer.attributes.totalRevenueCurrencyFormatted)
                    LabeledContent("MRR", value: customer.attributes.mrrFormatted)
                    LabeledContent("Customer Portal", value: customer.attributes.urls.customerPortal)
                }
            }
        }
        .navigationTitle("Get Customer")
    }
}

struct GetCustomer_Previews: PreviewProvider {
    static var previews: some View {
        GetCustomer()
    }
}
