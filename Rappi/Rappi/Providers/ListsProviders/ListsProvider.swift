import Foundation

protocol ListsProvider {
    
    func getPopular(completionHandler: @escaping ([Listable]) -> (), errorHandler: @escaping (_ message: String) -> ())
    func getTopRated(completionHandler: @escaping ([Listable]) -> (), errorHandler: @escaping (_ message: String) -> ())
    func getUpcoming(completionHandler: @escaping ([Listable]) -> (), errorHandler: @escaping (_ message: String) -> ())
}
