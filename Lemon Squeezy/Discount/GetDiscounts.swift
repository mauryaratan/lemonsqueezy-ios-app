//
//  GetDiscounts.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetDiscounts: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var discounts: [Discount]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getDiscounts()
                            withAnimation {
                                discounts = result.data
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
                    Text("Get discounts")
                }
            }
            
            if let discounts {
                Section {
                    ForEach(discounts) { discount in
                        NavigationLink {
                            GetDiscount(discount: discount)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(discount.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get discounts")
    }
}

struct GetDiscounts_Previews: PreviewProvider {
    static var previews: some View {
        GetDiscounts()
    }
}
