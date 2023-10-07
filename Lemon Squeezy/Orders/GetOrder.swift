//
//  GetOrder.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI
import LemonSqueezy

struct GetOrder: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var order: Order?
    @State var errors: [LemonSqueezyAPIError] = []
    @State var orderId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Order ID", text: $orderId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getOrder(orderId)
                            withAnimation {
                                order = result.data
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
                    Text("Get Order")
                }
                .disabled(orderId.isEmpty)
            }
            
            if let order {
                Section("Order") {
                    LabeledContent("Identifier", value: order.attributes.identifier)
                    LabeledContent("Price", value: String(order.attributes.totalFormatted))
                    LabeledContent("User Name", value: order.attributes.userName ?? "")
                    LabeledContent("User Email", value: order.attributes.userEmail ?? "")
                    LabeledContent("Receipt:", value: order.attributes.urls.receipt)
                }
            }
        }
        .navigationTitle("Get Order")
    }
}

struct GetOrder_Previews: PreviewProvider {
    static var previews: some View {
        GetOrder()
    }
}
