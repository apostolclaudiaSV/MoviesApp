//
//  UserDefaults+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 2/3/23.
//

import UIKit

extension FileManager {
    static func createOrFindDirectory(named name: String) -> URL? {
        let folderURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            return folderURL
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func createFile(named name: String, image: UIImage, _ folderName: String) -> URL? {
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
    
    static func getImageFromFile(at path: String) -> UIImage {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(path)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)!

        } catch {
            print(error.localizedDescription)
            return UIImage(data: Icon.noImage.data)!
        }
    }
}
