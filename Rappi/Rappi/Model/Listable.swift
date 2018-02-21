import Foundation
import UIKit

protocol Listable: class {
    
    var id: Int { get }
    var title: String? { get }
    var releaseDate: String? { get }
    var posterUrl: URL? { get }
    var poster: UIImage? { get set }
    var overview: String? { get }
    var rate: Float? { get }
    
    func fetchPoster(completionHandler: @escaping () -> ())
}

extension Listable {
    
    func fetchPoster(completionHandler: @escaping () -> ()) {

        if let _ = self.poster {
            
            completionHandler()
            return
        }
        
        guard let posterUrl = self.posterUrl else {
            
            completionHandler()
            return
        }

        let downloadThumbnailTask = URLSession.shared.downloadTask(with: posterUrl) { [weak self] (url, urlResponse, error) in
            
            guard let strongSelf = self,
                let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
                    
                return
            }
            
            strongSelf.poster = image
            
            DispatchQueue.main.async {
                
                completionHandler()
            }
        }
        
        downloadThumbnailTask.resume()
    }
}
