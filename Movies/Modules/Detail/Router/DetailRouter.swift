//
//  DetailRouter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/24/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class DetailRouter: DetailRouterProtocol {
    
    static func createDetailModule(for movie: Movie) -> UIViewController {
        let view = DetailView()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let remoteDataManager = DetailRemoteDataManager()
        let router = DetailRouter()
        
        view.presenter = presenter
        presenter.movie = movie
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        return view
    }
}
