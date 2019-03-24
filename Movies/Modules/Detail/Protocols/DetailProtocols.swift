//
//  DetailProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/24/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: class {
    
    var presenter: DetailPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func update(for movie: Movie)
    
    func showError()
}

protocol DetailPresenterProtocol: class {
    
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    var movie: Movie! { get set }
    
    // View -> Presenter
    
    func viewDidLoad()
    
    func didTapFavoriteButton()
}

protocol DetailRouterProtocol: class {
    
    static func createDetailModule(for movie: Movie) -> UIViewController
    
    // Presenter -> Router
    
}

protocol DetailInteractorOutputProtocol: class {
    
    // Interactor -> Presenter
    
    func didFetchDetails(for movie: Movie)
    
    func onError()
}

protocol DetailInteractorInputProtocol: class {
    
    var presenter: DetailInteractorOutputProtocol? { get set }
    var remoteDataManager: DetailRemoteDataManagerInputProtocol? { get set }
    
    // Presenter -> Interactor
    
    func fetchDetails(for movie: Movie)
}

protocol DetailRemoteDataManagerInputProtocol: class {
    
    var interactor: DetailRemoteDataManagerOutputProtocol? { get set }
    
    // Interactor -> RemoteDataManager
    
    func fetchDetails(for movie: Movie)
}

protocol DetailRemoteDataManagerOutputProtocol: class {
    
    // RemoteDataManager -> Interactor
    
    func onDetailsFetched(for movie: Movie)
    
    func onError()
}
