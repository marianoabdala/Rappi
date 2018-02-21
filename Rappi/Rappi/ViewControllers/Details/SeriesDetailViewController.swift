import Foundation
import UIKit

class SeriesDetailViewController: UITableViewController, DetailViewController {
    
    var item: Listable?
    var provider: DetailProvider?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var seasonsCountLabel: UILabel!
    @IBOutlet weak var episodesCountLabel: UILabel!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!

    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.configureActivityIndicatorView()
        self.loadData()
    }
}

private extension SeriesDetailViewController {
    
    func configureActivityIndicatorView() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
    }
    
    func loadData() {
        
        guard let item = self.item else {
            
            print("No item found.")
            return
        }
        
        self.posterImageView.image = item.poster
        self.titleLabel.text = item.title
        self.releaseDateLabel.text = item.releaseDate
        self.rateLabel.text = String(item.rate)
        self.overviewLabel.text = item.overview
        
        self.loadDetails(for: item)
    }
    
    func loadDetails(for item: Listable) {
        
        self.activityIndicatorView.startAnimating()
        
        self.provider?.getDetails(for: item,
            completionHandler: { [weak self] details in
            
                guard let strongSelf = self,
                    let seriesDetails = details as? SeriesDetails else {
                        
                        return
                }
                
                DispatchQueue.main.async {
                    
                    strongSelf.seasonsCountLabel.text = String(seriesDetails.seasonsCount)
                    strongSelf.episodesCountLabel.text = String(seriesDetails.episodesCount)
                    strongSelf.creatorsLabel.text = seriesDetails.creators
                    strongSelf.homepageLabel.text = seriesDetails.homepage
                    
                    strongSelf.activityIndicatorView.stopAnimating()
                }
            
            }, errorHandler: { errorMessage in
                
            print(errorMessage)
        })
    }
}
