import Foundation

protocol DetailProvider {
    
    func getDetails(for item: Listable, completionHandler: @escaping (Detailable) -> (), errorHandler: @escaping (_ message: String) -> ())
}
