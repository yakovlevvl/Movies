//
//  SearchView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class SearchView: UICollectionViewController {
    
    var presenter: SearchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        collectionView.backgroundColor = .white
    }
}

extension SearchView: SearchViewProtocol {
    
    func reloadData() {
        
    }
    
    func showError() {
        
    }
    
}
