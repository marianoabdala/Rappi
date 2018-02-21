import Foundation

class SeriesDetails: Detailable {
    
    let id: Int
    let seasonsCount: Int
    let episodesCount: Int
    let creators: String
    let homepage: String
    
    init?(with dictionary: [String: Any]) {
        
        guard let id = dictionary["id"] as? Int,
            let seasonsCount = dictionary["number_of_seasons"] as? Int,
            let episodesCount = dictionary["number_of_episodes"] as? Int,
            let creatorsArray = dictionary["created_by"] as? [[String: Any]],
            let homepage = dictionary["homepage"] as? String else {
                
                return nil
        }
        
        self.id = id
        self.seasonsCount = seasonsCount
        self.episodesCount = episodesCount
        self.creators = creatorsArray.flatMap { $0["name"] as? String }.joined(separator: ", ")
        self.homepage = homepage
    }
}
