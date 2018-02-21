import Foundation
import UIKit

class SeriesDetailViewController: UITableViewController, DetailViewController {
    
    var item: Listable?
    var provider: DetailProvider?
    var detail: SeriesDetails?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var seasonsCountLabel: UILabel!
    @IBOutlet weak var episodesCountLabel: UILabel!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var homepageButton: UIButton!

    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.configureActivityIndicatorView()
        self.loadData()
    }
    
    @IBAction func homepageButtonTapped(_ sender: Any) {

        guard let homepage = self.detail?.homepage,
            let url = URL(string: homepage) else {
                
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
        self.rateLabel.text = String(item.rate ?? 0)
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
                
                strongSelf.detail = seriesDetails
                
                DispatchQueue.main.async {
                    
                    strongSelf.seasonsCountLabel.text = String(seriesDetails.seasonsCount)
                    strongSelf.episodesCountLabel.text = String(seriesDetails.episodesCount)
                    strongSelf.creatorsLabel.text = seriesDetails.creators
                    strongSelf.homepageButton.setTitle(seriesDetails.homepage, for: .normal)
                    
                    strongSelf.activityIndicatorView.stopAnimating()
                }
            
            }, errorHandler: { errorMessage in
                
            print(errorMessage)
        })
    }
}
