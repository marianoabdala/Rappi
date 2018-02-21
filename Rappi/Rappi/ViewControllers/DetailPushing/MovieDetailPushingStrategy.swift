import Foundation
import UIKit

struct MovieDetailPushingStrategy: DetailPushingStrategy {
    
    let detailProvider: DetailProvider
    
    init(with detailProvider: DetailProvider) {
        
        self.detailProvider = detailProvider
    }
    
    func detailViewController(for item: Listable) -> UIViewController {
        
        guard let viewController = UIStoryboard(name: "MovieDetail", bundle: nil).instantiateInitialViewController() as? MovieDetailViewController else {
            
            print("Error instanciating MovieDetailViewController from MovieDetail storyboard.")
            return UIViewController()
        }
        
        viewController.item = item
        viewController.provider = detailProvider
        
        return viewController
    }
}
