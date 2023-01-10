//
//  GetFile.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 11/01/23.
//

import SwiftUI
import LemonSqueezy

struct GetFile: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var file: File?
    @State var errors: [LemonSqueezyAPIError] = []
    @State private var fileId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("File ID", text: $fileId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getFile(fileId)
                            withAnimation {
                                file = result.data
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
                    Text("Get File")
                }
                .disabled(fileId.isEmpty)
            }
            
            if let file {
                Section("File") {
                    LabeledContent("File Name", value: file.attributes.name)
                    LabeledContent("File Size", value: file.attributes.sizeFormatted)
                    LabeledContent("Extension", value: file.attributes.extension)
                    Link("Download", destination: URL(string: file.attributes.downloadUrl)!)
                }
            }
        }
        .navigationTitle("Get File")
    }
}

struct GetFile_Previews: PreviewProvider {
    static var previews: some View {
        GetFile()
    }
}
