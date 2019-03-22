//
//  FavoritesRouter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class FavoritesRouter: FavoritesRouterProtocol {
    
    static func createFavoritesModule() -> UIViewController {
        let view = FavoritesView(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return view
    }
    
    func presentDetailView(from view: FavoritesViewProtocol) {
        
    }
    
    
    
}
