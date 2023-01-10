//
//  GetProduct.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetProduct: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var product: Product?
    @State var errors: [LemonSqueezyAPIError] = []
    @State private var productId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Product ID", text: $productId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getProduct(productId)
                            withAnimation {
                                product = result.data
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
                    Text("Get Product")
                }
                .disabled(productId.isEmpty)
            }
            
            if let product {
                Section("Product") {
                    LabeledContent("Product Name", value: product.attributes.name)
                    LabeledContent("Slug", value: product.attributes.slug)
                    LabeledContent("Price", value: product.attributes.priceFormatted)
                    Link("Buy Now", destination: URL(string: product.attributes.buyNowUrl)!)
                }
            }
        }
        .navigationTitle("Get Product")
    }
}

struct GetProduct_Previews: PreviewProvider {
    static var previews: some View {
        GetProduct()
    }
}
