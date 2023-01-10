//
//  GetOrderItems.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetOrderItems: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var orderItems: [OrderItem]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getOrderItems()
                            withAnimation {
                                orderItems = result.data
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
                    Text("Get Order Items")
                }
            }
            
            if let orderItems {
                Section {
                    ForEach(orderItems) { orderItem in
                        NavigationLink {
                            GetOrderItem(orderItem: orderItem)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(orderItem.attributes.productName)
                                    Text(orderItem.attributes.variantName)
                                }
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Order Items")

    }
}

struct GetOrderItems_Previews: PreviewProvider {
    static var previews: some View {
        GetOrderItems()
    }
}
