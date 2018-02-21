import Foundation

class MovieDetails: Detailable {
    
    let id: Int
    let tagline: String
    let budget: Int
    let revenue: Int
    let genres: String
    let homepage: String

    init?(with dictionary: [String: Any]) {
        
        guard let id = dictionary["id"] as? Int,
            let tagline = dictionary["tagline"] as? String,
            let budget = dictionary["budget"] as? Int,
            let revenue = dictionary["revenue"] as? Int,
            let genresArray = dictionary["genres"] as? [[String: Any]],
            let homepage = dictionary["homepage"] as? String else {
        
            return nil
        }
        
        self.id = id
        self.tagline = tagline
        self.budget = budget
        self.revenue = revenue
        self.genres = genresArray.flatMap { $0["name"] as? String }.joined(separator: ", ")
        self.homepage = homepage
    }
}
