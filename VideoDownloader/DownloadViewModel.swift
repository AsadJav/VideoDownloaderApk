//
//  DownloadViewModel.swift
//  VideoDownloader
//
//  Created by Dev on 21/08/2025.
//

import Foundation

class DownloadViewModel: ObservableObject {
    func downloadVideo(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Download error:", error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Try to detect extension
            var fileExtension = "mp4"
            if let mimeType = response?.mimeType {
                if mimeType == "video/quicktime" {
                    fileExtension = "mov"
                } else if mimeType == "video/x-matroska" {
                    fileExtension = "mkv"
                }
            }
            
            let filename = url.lastPathComponent.isEmpty ? "video.\(fileExtension)" : url.lastPathComponent
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documents.appendingPathComponent(filename)
            
            do {
                try data.write(to: destinationURL)
                print("Video saved at:", destinationURL.path)
            } catch {
                print("Save error:", error)
            }
        }
        
        task.resume()
    }
}
