import Foundation
import UIKit

class ListableMovie: Listable {
    
    let id: Int
    let title: String
    let releaseDate: String
    let posterUrl: URL
    var poster: UIImage?
    let overview: String
    let rate: Float
    
    init?(with dictionary: [String: Any]) {

        guard let id = dictionary["id"] as? Int,
            let title = dictionary["original_title"] as? String,
            let releaseDate = dictionary["release_date"] as? String,
            let posterPath = dictionary["poster_path"] as? String,
            let posterUrl = URL(string: "https://image.tmdb.org/t/p/w154" + posterPath),
            let overview = dictionary["overview"] as? String,
            let rate = dictionary["vote_average"] as? Float else {

            return nil
        }

        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterUrl = posterUrl
        self.overview = overview
        self.rate = rate
    }
}
