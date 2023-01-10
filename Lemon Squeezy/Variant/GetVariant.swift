//
//  GetVariant.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetVariant: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var variant: Variant?
    @State var errors: [LemonSqueezyAPIError] = []
    @State private var variantId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Variant ID", text: $variantId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getVariant(variantId)
                            withAnimation {
                                variant = result.data
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
                    Text("Get Variant")
                }
                .disabled(variantId.isEmpty)
            }
            
            if let variant {
                Section("Variant") {
                    LabeledContent("Variant Name", value: variant.attributes.name)
                    LabeledContent("Status", value: variant.attributes.statusFormatted)
                    LabeledContent("Status", value: variant.attributes.statusFormatted)
                }
            }
        }
        .navigationTitle("Get Variant")

    }
}

struct GetVariant_Previews: PreviewProvider {
    static var previews: some View {
        GetVariant()
    }
}
