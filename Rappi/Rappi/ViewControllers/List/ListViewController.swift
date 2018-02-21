import Foundation
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    var listsProvider: ListsProvider?
    var detailPushingStrategy: DetailPushingStrategy?
    
    private var popular = [Listable]()
    private var topRated = [Listable]()
    private var upcoming = [Listable]()
    
    private var items: [Listable] {
        
        get {
            
            switch self.segmentedControl.selectedSegmentIndex {
                
                case 0: return self.popular
                case 1: return self.topRated
                case 2: return self.upcoming
                default: return []
            }
        }
    }
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.configureActivityIndicatorView()
        self.configureTableView()
        self.updatePopular()
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
     
        self.tableView.reloadData()
        self.updateList(at: self.segmentedControl.selectedSegmentIndex)
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ListableTableViewCell.id, for: indexPath) as? ListableTableViewCell else {
            
            print("Error obtaining cell with id: \(ListableTableViewCell.id).")
            return UITableViewCell()
        }
        
        cell.configure(with: self.items[indexPath.row])
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.items[indexPath.row]
        
        guard let detailViewController = self.detailPushingStrategy?.detailViewController(for: item) else {
        
            print("Error obtianing detail view controller.")
            return
        }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

private extension ListViewController {

    func configureActivityIndicatorView() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
    }
    
    func configureTableView() {
        
        self.tableView.register(UINib(nibName: "ListableTableViewCell", bundle: nil), forCellReuseIdentifier: ListableTableViewCell.id)
    }
    
    func updateList(at index: Int) {
        
        switch index {
            
            case 0: self.updatePopular()
            case 1: self.updateTopRated()
            case 2: self.updateUpcoming()
            default: break
        }
    }
    
    func updatePopular() {
        
        self.startLoading()
        
        self.listsProvider?.getPopular(completionHandler: { [weak self] items in
            
            self?.popular = items
            
            DispatchQueue.main.async {

                self?.tableView.reloadData()
                self?.stopLoading()
            }

        }, errorHandler: { errorMessage in

            print(errorMessage)
        })
    }
    
    func updateTopRated() {
        
        self.startLoading()
        
        self.listsProvider?.getTopRated(completionHandler: { [weak self] items in
            
            self?.topRated = items
            
            DispatchQueue.main.async {

                self?.tableView.reloadData()
                self?.stopLoading()
            }
            
        }, errorHandler: { errorMessage in
            
            print(errorMessage)
        })
    }
    
    func updateUpcoming() {
        
        self.startLoading()
        
        self.listsProvider?.getUpcoming(completionHandler: { [weak self] items in
            
            self?.upcoming = items
            
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
                self?.stopLoading()
            }
            
        }, errorHandler: { errorMessage in
            
            print(errorMessage)
        })
    }

    func startLoading() {

        self.segmentedControl.isEnabled = false
        self.activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        
        self.segmentedControl.isEnabled = true
        self.activityIndicatorView.stopAnimating()
    }
}
