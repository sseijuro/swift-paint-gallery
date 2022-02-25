//
//  FileStorage.swift
//  paint-gallery-demotivator
//
//  Created by Alexandr Kozorez on 25.02.2022.
//

import UIKit

final class FileStorage {
    private static var storage: FileManager {
        FileManager.default
    }
    
    private static var documentDirectory: URL {
        storage.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var fileUrls: [URL] {
        ((try? storage.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)) ?? []).sorted {
            guard let lhsDate = try? $0.resourceValues(forKeys: [.creationDateKey]).creationDate,
                  let rhsDate = try? $1.resourceValues(forKeys: [.creationDateKey]).creationDate
            else { return false }
            return lhsDate > rhsDate
        }
    }
    
    static func save(withFileName filename: String, _ data: Data) -> Bool {
        storage.createFile(
            atPath: documentDirectory.appendingPathComponent(filename).path,
            contents: data,
            attributes: [FileAttributeKey.creationDate: Date()]
        )
    }
}
