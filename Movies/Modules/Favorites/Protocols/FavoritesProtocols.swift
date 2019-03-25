//
//  FavoritesProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol FavoritesViewProtocol: class {
    
    var presenter: FavoritesPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func reloadData()
    
    func insertItems(at indexes: Range<Int>)
    
    func endReloading()
    
    func showNoMoviesMessage()
    
    func hideNoMoviesMessage()
    
    func showSkeleton()
    
    func hideSkeleton()
    
    func showError()
}

protocol FavoritesPresenterProtocol: class {
    
    var view: FavoritesViewProtocol? { get set }
    var interactor: FavoritesInteractorInputProtocol? { get set }
    var router: FavoritesRouterProtocol? { get set }
    
    // View -> Presenter
    
    func viewDidLoad()
    
    func getMoviesCount() -> Int
    
    func getMovie(with index: Int) -> Movie
    
    func showDetailForMovie(with index: Int)
    
    func didFinishInsertItems()
    
    func paginate()
    
    func didReceiveMemoryWarning()
    
    func startReloading()
}

protocol FavoritesRouterProtocol: class {
    
    static func createFavoritesModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentDetailView(from view: FavoritesViewProtocol, for movie: Movie)
}

protocol FavoritesInteractorOutputProtocol: class {
    
    // Interactor -> Presenter
    
    func didFetchMovies(_ movies: [Movie], cache: Bool)
    
    func onError()
}

protocol FavoritesInteractorInputProtocol: class {
    
    var presenter: FavoritesInteractorOutputProtocol? { get set }
    var localDataManager: FavoritesLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: FavoritesRemoteDataManagerInputProtocol? { get set }
    
    // Presenter -> Interactor
    
    func fetchMovies(page: Int, includingCache: Bool)
}

protocol FavoritesRemoteDataManagerInputProtocol: class {
    
    var interactor: FavoritesRemoteDataManagerOutputProtocol? { get set }
    
    // Interactor -> RemoteDataManager
    
    func fetchMovies(page: Int)
}

protocol FavoritesRemoteDataManagerOutputProtocol: class {
    
    // RemoteDataManager -> Interactor
    
    func onMoviesFetched(_ movies: [Movie], page: Int)
    
    func onError()
}

protocol FavoritesLocalDataManagerInputProtocol: class {
    
    // Interactor -> LocalDataManager
    
    func fetchMovies() -> [Movie]?
    
    func cacheMovies(_ movies: [Movie])
}
