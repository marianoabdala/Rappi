import Foundation
import UIKit

class MovieDetailViewController: UITableViewController, DetailViewController {
    
    var item: Listable?
    var provider: DetailProvider?
    var detail: MovieDetails?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
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

private extension MovieDetailViewController {
    
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

        self.provider?.getDetails(for: item, completionHandler: { [weak self] details in
            
            guard let strongSelf = self,
                let movieDetails = details as? MovieDetails else {
                    
                return
            }
            
            strongSelf.detail = movieDetails
            
            DispatchQueue.main.async {
                
                strongSelf.taglineLabel.text = movieDetails.tagline
                strongSelf.budgetLabel.text = NumberFormatter.localizedString(from: NSNumber(value: movieDetails.budget), number: NumberFormatter.Style.decimal)
                strongSelf.revenueLabel.text = NumberFormatter.localizedString(from: NSNumber(value: movieDetails.revenue), number: NumberFormatter.Style.decimal)
                strongSelf.genresLabel.text = movieDetails.genres
                strongSelf.homepageButton.setTitle(movieDetails.homepage, for: .normal) 
                
                strongSelf.activityIndicatorView.stopAnimating()
            }
            
        }, errorHandler: { errorMessage in
            
            print(errorMessage)
        })
    }
}
