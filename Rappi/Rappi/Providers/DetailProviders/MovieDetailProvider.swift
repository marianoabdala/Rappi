import Foundation

class MovieDetailProvider: DetailProvider {
    
    private let client: Client
    
    init(with client: Client) {
        
        self.client = client
    }

    func getDetails(for item: Listable, completionHandler: @escaping (Detailable) -> (), errorHandler: @escaping (String) -> ()) {

        self.client.fetch(url: "https://api.themoviedb.org/3/movie/\(item.id)?api_key=38db2dc80c7f480b4692ed5dd21d864d&language=en-US", requiresHeaders: false,
            completionHandler: { dictionary in

                guard let movieDetails = MovieDetails(with: dictionary) else {
                    
                    errorHandler("Unable to parse movie details.")
                    return
                }
                
                completionHandler(movieDetails)
            },
            errorHandler: { message in

                errorHandler(message)
        })
    }
}
