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
        let interactor = SearchInteractor()
        let remoteDataManager = SearchRemoteDataManager()
        let router = SearchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        return view
    }
    
    func presentDetailView(from view: SearchViewProtocol, for movie: Movie) {
        let detailViewController = DetailRouter.createDetailModule(for: movie)
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
