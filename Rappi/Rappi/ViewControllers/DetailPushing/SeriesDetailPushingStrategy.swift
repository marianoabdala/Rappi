//
//  SeriesDetailPushingStrategy.swift
//  Rappi
//
//  Created by Mariano Abdala on 21/02/2018.
//  Copyright © 2018 Zerously. All rights reserved.
//

import Foundation
import UIKit

struct SeriesDetailPushingStrategy: DetailPushingStrategy {
    
    let detailProvider: DetailProvider
    
    init(with detailProvider: DetailProvider) {
        
        self.detailProvider = detailProvider
    }
    
    func detailViewController(for item: Listable) -> UIViewController {
        
        guard let viewController = UIStoryboard(name: "SeriesDetail", bundle: nil).instantiateInitialViewController() as? SeriesDetailViewController else {
            
            print("Error instanciating SeriesDetailViewController from SeriesDetail storyboard.")
            return UIViewController()
        }
        
        viewController.item = item
        viewController.provider = detailProvider
        
        return viewController
    }
}

