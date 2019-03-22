//
//  PopularRouter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class PopularRouter: PopularRouterProtocol {
    
    static func createPopularModule() -> UIViewController {
        let view = PopularView(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = PopularPresenter()
        let router = PopularRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return view
    }
    
    func presentDetailView(from view: PopularViewProtocol) {
        
    }
    
}
