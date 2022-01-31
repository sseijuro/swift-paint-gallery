import Foundation
import UIKit

final class FileStore {
    private static var storage: FileManager {
        FileManager.default
    }
    
    private static var documentDirectory: URL {
        storage.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var fileUrls: [URL] {
        (try? storage.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)) ?? []
    }
}

extension FileStore {
    static func saveImage(withFileName filename: String, _ image: UIImage) -> Bool {
        guard let imageData = image.pngData() else { return false }
        return storage.createFile(
            atPath: documentDirectory.appendingPathComponent(filename).path,
            contents: imageData,
            attributes: [FileAttributeKey.creationDate: Date()]
        )
    }
    
    static func deleteImage(withFileName filename: String) {
        let fileURL = documentDirectory.appendingPathComponent(filename)
        if storage.fileExists(atPath: fileURL.path) {
            try? storage.removeItem(at: fileURL)
        }
    }
}
