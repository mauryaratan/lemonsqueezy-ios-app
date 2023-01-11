//
//  GetDiscount.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetDiscount: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var discount: Discount?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("discountId") var discountId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Discount ID", text: $discountId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getDiscount(discountId)
                            withAnimation {
                                discount = result.data
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
                    Text("Get Discount")
                }
                .disabled(discountId.isEmpty)
            }
            
            if let discount {
                Section("Discount") {
                    LabeledContent("Discount name", value: discount.attributes.name)
                    LabeledContent("Discount code", value: discount.attributes.code)
                    LabeledContent("Discount amount", value: String(discount.attributes.amount))
                    LabeledContent("Discount type", value: discount.attributes.amountType)
                    LabeledContent("Status", value: discount.attributes.statusFormatted)
                    LabeledContent("Duration", value: discount.attributes.duration)
                    LabeledContent("Duration in months", value: String(discount.attributes.durationInMonths))
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
        .navigationTitle("Get Discount")
    }
}

struct GetDiscount_Previews: PreviewProvider {
    static var previews: some View {
        GetDiscount()
    }
}
