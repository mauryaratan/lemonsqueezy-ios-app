//
//  GetCustomers.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 28/03/23.
//

import SwiftUI
import LemonSqueezy

struct GetCustomers: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var customers: [Customer]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getCustomers()
                            withAnimation {
                                customers = result.data
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
                    Text("Get Customers")
                }
            }
            
            if let customers {
                Section {
                    ForEach(customers) { customer in
                        NavigationLink {
                            GetCustomer(customer: customer)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(customer.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Customers")
    }
}

struct GetCustomers_Previews: PreviewProvider {
    static var previews: some View {
        GetCustomers()
    }
}
