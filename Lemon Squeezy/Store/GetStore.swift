//
//  GetStore.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI
import LemonSqueezy

struct GetStore: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var store: Store?
    @State var errors: [LemonSqueezyAPIError] = []
    @State private var storeId = "13"
    
    var body: some View {
        Form {
            Section {
                TextField("Store ID", text: $storeId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getStore(storeId)
                            withAnimation {
                                store = result.data
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
                    Text("Get Store")
                }
                .disabled(storeId.isEmpty)
            }
            
            if let store {
                Section("Store") {
                    LabeledContent("Name", value: store.attributes.name)
                    LabeledContent("Slug", value: store.attributes.slug)
                    LabeledContent("URL", value: store.attributes.url)
                    LabeledContent("Country Code", value: store.attributes.country)
                    LabeledContent("Country", value: store.attributes.countryNicename)
                }
            }
            
        }
    }
}

struct GetStore_Previews: PreviewProvider {
    static var previews: some View {
        GetStore()
    }
}
