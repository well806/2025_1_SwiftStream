import UIKit

final class AvatarStorage {
    private static let maxCompressionQuality: CGFloat = 0.7
    private static let maxSize: CGFloat = 800
    

    private static let fileQueue = DispatchQueue(label: "com.app.avatar",
                                                  attributes: .concurrent)

    private static func fileURL(for userID: String) -> URL? {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?.appendingPathComponent("avatar_\(userID).jpg")
    }

    static func save(_ image: UIImage?, userID: String) async {
        
        guard let image = image, let url = fileURL(for: userID) else { return }

        let resized = resize(image, to: maxSize)
        guard let data = resized.jpegData(compressionQuality: maxCompressionQuality) else { return }
        
        await withCheckedContinuation { continuation in
            fileQueue.async {
                try? data.write(to: url)
                continuation.resume()
            }
        }
    }

    static func load(userID: String) async -> UIImage? {
        guard let url = fileURL(for: userID) else { return nil }

        return await withCheckedContinuation { continuation in
            fileQueue.async {
                let data = try? Data(contentsOf: url)
                let image = data.flatMap { UIImage(data: $0) }
                continuation.resume(returning: image)
            }
        }
    }

    static func delete(userID: String) {
        guard let url = fileURL(for: userID) else { return }
        try? FileManager.default.removeItem(at: url)
    }

    private static func resize(_ image: UIImage, to maxSize: CGFloat) -> UIImage {
        let coef = max(image.size.width, image.size.height) / maxSize
        guard coef > 1 else { return image }
        
        let newSize = CGSize(width: image.size.width / coef,
                            height: image.size.height / coef)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? image
    }
}
