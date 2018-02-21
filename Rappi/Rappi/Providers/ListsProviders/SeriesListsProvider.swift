import Foundation

class SeriesListsProvider: ListsProvider {
    
    private let client: Client
    
    init(with client: Client) {
        
        self.client = client
    }
    
    func getPopular(completionHandler: @escaping ([Listable]) -> (), errorHandler: @escaping (_ message: String) -> ()) {
    
        self.client.fetch(url: "https://api.themoviedb.org/4/discover/tv?sort_by=popularity.desc", requiresHeaders: true,
            completionHandler: { dictionary in

                guard let results = dictionary["results"] as? [[String: Any]] else {

                    errorHandler("Empty results.")
                    return
                }

                let series = results.flatMap { ListableSeries(with: $0) }

                completionHandler(series)
            },
            errorHandler: { message in

                errorHandler(message)
        })
    }
    
    func getTopRated(completionHandler: @escaping ([Listable]) -> (), errorHandler: @escaping (_ message: String) -> ()) {
    
        self.client.fetch(url: "https://api.themoviedb.org/4/discover/tv?sort_by=vote_average.desc", requiresHeaders: true,
            completionHandler: { dictionary in

                guard let results = dictionary["results"] as? [[String: Any]] else {

                    errorHandler("Empty results.")
                    return
                }

                let series = results.flatMap { ListableSeries(with: $0) }

                completionHandler(series)
            },
            errorHandler: { message in

            errorHandler(message)
        })
    }
    
    func getUpcoming(completionHandler: @escaping ([Listable]) -> (), errorHandler: @escaping (_ message: String) -> ()) {
    
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateParam = apiDateFormatter.string(from: Date())
        
        self.client.fetch(url: "https://api.themoviedb.org/4/discover/tv?primary_release_date.gte=\(dateParam)&sort_by=primary_release_date.ask", requiresHeaders: true,
            completionHandler: { dictionary in

                guard let results = dictionary["results"] as? [[String: Any]] else {

                    errorHandler("Empty results.")
                    return
                }

                let series = results.flatMap { ListableSeries(with: $0) }

                completionHandler(series)
            },
            errorHandler: { message in

                errorHandler(message)
            })
    }
}
