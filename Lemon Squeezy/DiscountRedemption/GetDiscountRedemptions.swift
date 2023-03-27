//
//  GetDiscountRedemptions.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 28/03/23.
//

import SwiftUI
import LemonSqueezy

struct GetDiscountRedemptions: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var discountRedemptions: [DiscountRedemption]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getDiscountRedemptions()
                            withAnimation {
                                discountRedemptions = result.data
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
                    Text("Get discounts redemptions")
                }
            }
            
            if let discountRedemptions {
                Section {
                    ForEach(discountRedemptions) { discountRedemption in
                        NavigationLink {
                            GetDiscountRedemption(discountRedemption: discountRedemption)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(discountRedemption.attributes.discountName)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get discounts redemptions")
    }
}

struct GetDiscountRedemptions_Previews: PreviewProvider {
    static var previews: some View {
        GetDiscountRedemptions()
    }
}
