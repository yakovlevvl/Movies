//
//  FavoritesView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class FavoritesView: UICollectionViewController {
    
    var presenter: FavoritesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        collectionView.backgroundColor = .white
    }
}

extension FavoritesView: FavoritesViewProtocol {
    
    func reloadData() {
        
    }
    
    func showError() {
        
    }
    
    
    
}
