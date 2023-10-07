//
//  GetPrices.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetPrices: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var prices: [Price]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getPrices()
                            withAnimation {
                                prices = result.data
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
                    Text("Get prices")
                }
            }
            
            if let prices {
                Section {
                    ForEach(prices) { price in
                        NavigationLink {
                            GetPrice(price: price)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(price.attributes.category)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get prices")
    }
}

#Preview {
    GetPrices()
}
