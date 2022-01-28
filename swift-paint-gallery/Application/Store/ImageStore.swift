import UIKit

protocol ImageStoreAddImage {
    static func addImage(image: UIImage)
}

protocol ImageStoreGetImage {
    static func getImage(byIndex index: Int) -> Data?
}

final class ImageStore {
    private static let imageStoreKey = String(describing: ImageStore.self)
    
    private static var imageArray: [Data] {
        get { UserDefaults.standard.array(forKey: imageStoreKey) as? [Data] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: imageStoreKey) }
    }
    
    static var count: Int { imageArray.count }
    
    static func getImage(byIndex index: Int) -> Data? {
        guard imageArray.count > index else { return nil }
        return imageArray[index]
    }
    
    static func addImage(image: UIImage) {
        guard let data = image.pngData() else { return }
        var newImageArray = imageArray
        newImageArray.append(data)
        imageArray = newImageArray
    }
}

