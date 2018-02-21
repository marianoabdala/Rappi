import Foundation
import UIKit

class ListableSeries: Listable {
    
    let id: Int
    let title: String?
    let releaseDate: String?
    let posterUrl: URL?
    var poster: UIImage?
    let overview: String?
    let rate: Float?
    
    init?(with dictionary: [String: Any]) {
        
        guard let id = dictionary["id"] as? Int else {
            
            return nil
        }
        
        self.id = id
        self.title = dictionary["original_name"] as? String
        self.releaseDate = dictionary["first_air_date"] as? String
        
        if let posterPath = dictionary["poster_path"] as? String {

            self.posterUrl = URL(string: "https://image.tmdb.org/t/p/w154" + posterPath)
        } else {
            
            self.posterUrl = nil
        }
        
        self.overview = dictionary["overview"] as? String
        self.rate = dictionary["vote_average"] as? Float
    }
}
