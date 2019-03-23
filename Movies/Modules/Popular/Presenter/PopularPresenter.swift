//
//  PopularPresenter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class PopularPresenter: PopularPresenterProtocol {
    
    weak var view: PopularViewProtocol?
    var interactor: PopularInteractorInputProtocol?
    var router: PopularRouterProtocol?
    
    private var movies = [Movie]()
    
    private var paginationEnabled = false
    
    private var nextPage = 1
    
    func viewDidLoad() {
        interactor?.fetchMovies(page: nextPage)
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getMovie(with index: Int) -> Movie {
        return movies[index]
    }
    
    func showDetailForMovie(with index: Int) {
        router?.presentDetailView(from: view!, for: movies[index])
    }
    
    func paginate() {
        guard paginationEnabled else { return }
        paginationEnabled = false
        interactor?.fetchMovies(page: nextPage)
    }
}

extension PopularPresenter: PopularInteractorOutputProtocol {
    
    func didFetchMovies(_ movies: [Movie]) {
        guard !movies.isEmpty else {
            paginationEnabled = false
            return
        }
        self.movies += movies
        view?.reloadData()
        nextPage += 1
        paginationEnabled = true
    }
    
    func onError() {
        view?.showError()
        paginationEnabled = true
    }
}
