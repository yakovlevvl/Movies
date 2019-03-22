//
//  SearchRouter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    static func createSearchModule() -> UIViewController {
        let view = SearchView(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return view
    }
    
    func presentDetailView(from view: SearchViewProtocol) {
        
    }
    
    
    
}
