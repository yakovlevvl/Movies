//
//  PopularView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class PopularView: UICollectionViewController {
    
    var presenter: PopularPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = "Popular"
    }
}

extension PopularView: PopularViewProtocol {
    
    func reloadData() {
        
    }
    
    func showError() {
        
    }
    
}
