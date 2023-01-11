//
//  GetCheckouts.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetCheckouts: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var checkouts: [Checkout]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getCheckouts()
                            withAnimation {
                                checkouts = result.data
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
                    Text("Get checkouts")
                }
            }
            
            if let checkouts {
                Section {
                    ForEach(checkouts) { checkout in
                        NavigationLink {
                            GetCheckout(checkout: checkout)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(String(checkout.attributes.variantId))
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get checkouts")
    }
}

struct GetCheckouts_Previews: PreviewProvider {
    static var previews: some View {
        GetCheckouts()
    }
}
