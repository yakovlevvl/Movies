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
        let interactor = FavoritesInteractor()
        let localDataManager = FavoritesLocalDataManager()
        let remoteDataManager = FavoritesRemoteDataManager()
        let router = FavoritesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        return view
    }
    
    func presentDetailView(from view: FavoritesViewProtocol, for movie: Movie) {
        let detailViewController = DetailRouter.createDetailModule(for: movie)
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
