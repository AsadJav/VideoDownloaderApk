//
//  ContentView.swift
//  VideoDownloader
//
//  Created by Dev on 21/08/2025.
//

import SwiftUI
import Photos

struct ContentView: View {
    @StateObject var vm = DownloadViewModel()
    @State private var urlString: String = ""
    @State private var isDownloading = false
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Paste video URL", text: $urlString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                if let url = URL(string: urlString) {
                    vm.downloadVideo(from: url)
                }
            } label: {
                Text("Download")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(isDownloading || urlString.isEmpty)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
