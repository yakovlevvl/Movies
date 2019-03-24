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
        let interactor = PopularInteractor()
        let localDataManager = PopularLocalDataManager()
        let remoteDataManager = PopularRemoteDataManager()
        let router = PopularRouter()
        
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
    
    func presentDetailView(from view: PopularViewProtocol, for movie: Movie) {
        let detailViewController = DetailRouter.createDetailModule(for: movie)
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
