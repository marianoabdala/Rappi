import Foundation
import UIKit

protocol DetailPushingStrategy {
    
    var detailProvider: DetailProvider { get }
    
    func detailViewController(for item: Listable) -> UIViewController
}
