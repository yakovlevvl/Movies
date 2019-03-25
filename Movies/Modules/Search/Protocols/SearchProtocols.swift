//
//  SearchProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    
    var presenter: SearchPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func reloadData()
    
    func insertItems(at indexes: Range<Int>)
    
    func showNoMoviesMessage()
    
    func hideNoMoviesMessage()
    
    func showSkeleton()
    
    func hideSkeleton()
    
    func showError()
}

protocol SearchPresenterProtocol: class {
    
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    
    // View -> Presenter
    
    func updateSearchResults(for searchText: String)
    
    func getMoviesCount() -> Int
    
    func getMovie(with index: Int) -> Movie
    
    func showDetailForMovie(with index: Int)
    
    func didFinishInsertItems()
    
    func paginate()
    
    func didReceiveMemoryWarning()
}

protocol SearchRouterProtocol: class {
    
    static func createSearchModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentDetailView(from view: SearchViewProtocol, for movie: Movie)
}

protocol SearchInteractorOutputProtocol: class {
    
    // Interactor -> Presenter
    
    func didFetchResults(_ results: [Movie])
    
    func onError()
}

protocol SearchInteractorInputProtocol: class {
    
    var presenter: SearchInteractorOutputProtocol? { get set }
    var remoteDataManager: SearchRemoteDataManagerInputProtocol? { get set }
    
    // Presenter -> Interactor
    
    func fetchResults(for searchText: String, page: Int)
}

protocol SearchRemoteDataManagerInputProtocol: class {
    
    var interactor: SearchRemoteDataManagerOutputProtocol? { get set }
    
    // Interactor -> RemoteDataManager
    
    func fetchResults(for searchText: String, page: Int)
}

protocol SearchRemoteDataManagerOutputProtocol: class {
    
    // RemoteDataManager -> Interactor
    
    func onResultsFetched(_ results: [Movie])

    func onError()
}
