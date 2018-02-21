import Foundation

protocol DetailViewController {
    
    var item: Listable? { get }
    var provider: DetailProvider? { get }
}
