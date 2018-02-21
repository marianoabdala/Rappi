import UIKit

class ListableTableViewCell: UITableViewCell {

    static let id = "ListableTableViewCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var listable: Listable?

    override func prepareForReuse() {
        
        self.listable = nil
        self.posterImageView.image = nil
    }
    
    func configure(with listable: Listable) {
        
        self.listable = listable
     
        self.titleLabel.text = listable.title
        self.releaseDateLabel.text = listable.releaseDate
        self.rateLabel.text = String(listable.rate)
        self.overviewLabel.text = listable.overview
        
        listable.fetchPoster { [weak self] in
            
            self?.posterImageView.image = self?.listable?.poster
        }
    }
}
