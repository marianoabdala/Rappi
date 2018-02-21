import Foundation

class Client {
    
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)

    func fetch(url: String, requiresHeaders: Bool, completionHandler: @escaping ([String: AnyObject]) -> (), errorHandler: @escaping (_ message: String) -> ()) {

        guard let url = URL(string: url) else {
            
            errorHandler("Incorrect URL.")
            return
        }
        
        var request = URLRequest(url: url)
        
        if requiresHeaders {
            
            request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGRiMmRjODBjN2Y0ODBiNDY5MmVkNWRkMjFkODY0ZCIsInN1YiI6IjVhN2UxMGE2YzNhMzY4MTdkMzAwNTViNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CPKNHHBhqhAA8ZEuWRDuwNLGsq7vUKZ4MimekYO-8ng", forHTTPHeaderField: "Authorization")
            request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            
            guard let _ = response else {
                
                errorHandler("Please check your internet connection. Server may be down.")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                errorHandler("Invalid server response type.")
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            guard statusCode == 200 else {
                
                errorHandler("Invalid response code: \(statusCode).")
                return
            }
            
            guard let data = data else {
                
                errorHandler("Invalid response Data (empty).")
                return
            }
            
            do {
                
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] else {
                    
                    errorHandler("An error occurrred parsing the response.")
                    return
                }
                
                completionHandler(dictionary)
                
            } catch {
                
                errorHandler("An error occurrred parsing the response.")
            }
        }
        
        dataTask.resume()
    }
}
