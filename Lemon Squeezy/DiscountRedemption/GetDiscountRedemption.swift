//
//  GetDiscountRedemption.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 28/03/23.
//

import SwiftUI
import LemonSqueezy

struct GetDiscountRedemption: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var discountRedemption: DiscountRedemption?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("discountRedemptionId") var discountRedemptionId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Discount Redemption ID", text: $discountRedemptionId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getDiscountRedemption(discountRedemptionId)
                            withAnimation {
                                discountRedemption = result.data
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
                    Text("Get Discount Redemption")
                }
                .disabled(discountRedemptionId.isEmpty)
            }
            
            if let discountRedemption {
                Section("Discount") {
                    LabeledContent("Discount ID", value: discountRedemption.id)
                    LabeledContent("Discount Order ID", value: String(discountRedemption.attributes.orderId))
                    LabeledContent("Discount Name", value: discountRedemption.attributes.discountName)
                    LabeledContent("Discount Code", value: discountRedemption.attributes.discountCode)
                    LabeledContent("Discount Amount Type", value: discountRedemption.attributes.discountAmountType)
                    LabeledContent("Discount Amount", value: String(discountRedemption.attributes.discountAmount))
                }
            }
            
            if !errors.isEmpty {
              Section("Errors") {
                ForEach(errors, id: \.self) { error in
                    Text(String(describing: error.localizedDescription))
                }
              }
            }
        }
        .navigationTitle("Get Discount Redemption")
    }
}

struct GetDiscountRedemption_Previews: PreviewProvider {
    static var previews: some View {
        GetDiscountRedemption()
    }
}
