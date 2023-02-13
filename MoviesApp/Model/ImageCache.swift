//
//  UserDefaults+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 2/3/23.
//

import UIKit

class ImageCache {
    
    private func createURL(for path: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(path)
    }
    
    private func createOrFindDirectory(named name: String) -> URL? {
        let folderURL = createURL(for: name)
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            return folderURL
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    @discardableResult func createFile(named name: String, image: UIImage, _ folderName: String) -> URL? {
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
        let fileURL = createURL(for: path)
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
