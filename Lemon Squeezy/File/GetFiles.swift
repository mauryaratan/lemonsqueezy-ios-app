//
//  GetFiles.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetFiles: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var files: [File]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getFiles()
                            withAnimation {
                                files = result.data
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
                    Text("Get files")
                }
            }
            
            if let files {
                Section {
                    ForEach(files) { file in
                        NavigationLink {
                            GetFile(file: file)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(file.attributes.name)
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get Files")

    }
}

struct GetFiles_Previews: PreviewProvider {
    static var previews: some View {
        GetFiles()
    }
}
