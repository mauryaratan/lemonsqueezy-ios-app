//
//  GetStores.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetStores: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var stores: [Store]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getStores()
                            withAnimation {
                                stores = result.data
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
                    Text("Get stores")
                }
            }
            
            if let stores {
                Section {
                    ForEach(stores) { store in
                        NavigationLink {
                            GetStore(store: store)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(store.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Orders")

    }
}

struct GetStores_Previews: PreviewProvider {
    static var previews: some View {
        GetStores()
    }
}
