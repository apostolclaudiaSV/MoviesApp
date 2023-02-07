//
//  UserDefaults+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 2/3/23.
//

import UIKit

class ImageCache {
//    static let shared = ImageCache()
//    private init() {}
    
    private func createOrFindDirectory(named name: String) -> URL? {
        let folderURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            return folderURL
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func createFile(named name: String, image: UIImage, _ folderName: String) -> URL? {
        guard let folderURL = createOrFindDirectory(named: folderName) else {
            return nil
        }
        let fileURL = folderURL.appendingPathComponent(name)
        do {
            try image.pngData()!.write(to: fileURL)
            return fileURL
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getImageFromFile(at path: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(path)
        do {
            let imageData = try Data(contentsOf: fileURL)
            let image = UIImage(data: imageData)!
            return image
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
