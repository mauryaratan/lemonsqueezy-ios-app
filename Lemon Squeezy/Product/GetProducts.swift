//
//  GetProducts.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetProducts: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var products: [Product]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getProducts()
                            withAnimation {
                                products = result.data
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
                    Text("Get products")
                }
            }
            
            if let products {
                Section {
                    ForEach(products) { product in
                        NavigationLink {
                            GetProduct(product: product)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(product.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Products")
    }
}

struct GetProducts_Previews: PreviewProvider {
    static var previews: some View {
        GetProducts()
    }
}
