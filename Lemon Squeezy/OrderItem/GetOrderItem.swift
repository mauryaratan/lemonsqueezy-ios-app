//
//  GetOrderItem.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetOrderItem: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var orderItem: OrderItem?
    @State var errors: [LemonSqueezyAPIError] = []
    @State private var orderItemId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Order Item ID", text: $orderItemId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getOrderItem(orderItemId)
                            withAnimation {
                                orderItem = result.data
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
                    Text("Get Order Item")
                }
                .disabled(orderItemId.isEmpty)
            }
            
            if let orderItem {
                Section("Order Item") {
                    LabeledContent("Product name", value: orderItem.attributes.productName)
                    LabeledContent("Variant name", value: orderItem.attributes.variantName)
                }
            }
        }
        .navigationTitle("Get Order Item")
    }
}

struct GetOrderItem_Previews: PreviewProvider {
    static var previews: some View {
        GetOrderItem()
    }
}
