//
//  GetVariants.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetVariants: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var variants: [Variant]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getVariants()
                            withAnimation {
                                variants = result.data
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
                    Text("Get variants")
                }
            }
            
            if let variants {
                Section {
                    ForEach(variants) { variant in
                        NavigationLink {
                            GetVariant(variant: variant)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(variant.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Variants")

    }
}

struct GetVariants_Previews: PreviewProvider {
    static var previews: some View {
        GetVariants()
    }
}
