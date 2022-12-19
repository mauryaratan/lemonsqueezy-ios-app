//
//  GetOrders.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI
import LemonSqueezy

struct GetOrders: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var orders: [Order]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getOrders()
                            withAnimation {
                                orders = result.data
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
                    Text("Get orders")
                }
            }
            
            if let orders {
                Section {
                    ForEach(orders) { order in
                        NavigationLink {
                            GetOrder(order: order, orderId: order.id)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(order.attributes.userName)
                                    Spacer()
                                    Text(order.attributes.totalFormatted)
                                }
                                Text("\(order.attributes.firstOrderItem.productName) — \(order.attributes.firstOrderItem.variantName)")
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Orders")
    }
}

struct GetOrders_Previews: PreviewProvider {
    static var previews: some View {
        GetOrders()
    }
}
