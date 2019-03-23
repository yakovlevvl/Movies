//
//  PopularProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol PopularViewProtocol: class {
    
    var presenter: PopularPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func reloadData()
    
    func showError()
}

protocol PopularPresenterProtocol: class {
    
    var view: PopularViewProtocol? { get set }
    var interactor: PopularInteractorInputProtocol? { get set }
    var router: PopularRouterProtocol? { get set }
    
    // View -> Presenter
    
    func viewDidLoad()
    
    func getMoviesCount() -> Int
    
    func getMovie(with index: Int) -> Movie
    
    func showDetailForMovie(with index: Int)
    
    func paginate()
}

protocol PopularRouterProtocol: class {
    
    static func createPopularModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentDetailView(from view: PopularViewProtocol, for movie: Movie)
}

protocol PopularInteractorOutputProtocol: class {
    
    // Interactor -> Presenter
    
    func didFetchMovies(_ movies: [Movie])
    
    func onError()
}

protocol PopularInteractorInputProtocol: class {
    
    var presenter: PopularInteractorOutputProtocol? { get set }
    var localDataManager: PopularLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: PopularRemoteDataManagerInputProtocol? { get set }
    
    // Presenter -> Interactor
    
    func fetchMovies(page: Int)
}

protocol PopularRemoteDataManagerInputProtocol: class {
    
    var interactor: PopularRemoteDataManagerOutputProtocol? { get set }
    
    // Interactor -> RemoteDataManager
    
    func fetchMovies(page: Int)
}

protocol PopularRemoteDataManagerOutputProtocol: class {
    
    // RemoteDataManager -> Interactor
    
    func onMoviesFetched(_ movies: [Movie])
    
    func onError()
}

protocol PopularLocalDataManagerInputProtocol: class {
    
    // Interactor -> LocalDataManager
    
    func fetchMovies() -> [Movie]?
    
    func saveMoviesData(_ data: Data) throws
}
