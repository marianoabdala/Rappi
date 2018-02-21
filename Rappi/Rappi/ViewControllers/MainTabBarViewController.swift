import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.configureTabBarItems()
    }
}

private extension MainTabBarViewController {
    
    func configureTabBarItems() {
        
        // This has to be done programatically because we are using the same view controller
        // for both items and the UITabBarController doesn't work well with storyboard
        // references.
        let listStoryboard = UIStoryboard(name: "List", bundle: nil)
        
        guard let moviesNavigationController = listStoryboard.instantiateInitialViewController() as? UINavigationController,
            let moviesListViewController = moviesNavigationController.viewControllers.first as? ListViewController,
            let seriesNavigationController = listStoryboard.instantiateInitialViewController() as? UINavigationController,
            let seriesListViewController = seriesNavigationController.viewControllers.first as? ListViewController else {
                
                return
        }
        
        moviesNavigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "1055-ticket"), selectedImage: nil)
        seriesNavigationController.tabBarItem = UITabBarItem(title: "Series", image: UIImage(named: "969-television"), selectedImage: nil)
        
        let client = Client()
        
        moviesListViewController.listsProvider = MoviesListsProvider(with: client)
        moviesListViewController.detailPushingStrategy = MovieDetailPushingStrategy(with: MovieDetailProvider(with: client))
        
        seriesListViewController.listsProvider = SeriesListsProvider(with: client)
        seriesListViewController.detailPushingStrategy = SeriesDetailPushingStrategy(with: SeriesDetailProvider(with: client))

        self.viewControllers = [moviesNavigationController, seriesNavigationController]
    }
}
