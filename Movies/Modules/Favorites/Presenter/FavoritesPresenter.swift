//
//  FavoritesPresenter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class FavoritesPresenter: FavoritesPresenterProtocol {

    weak var view: FavoritesViewProtocol?
    var interactor: FavoritesInteractorInputProtocol?
    var router: FavoritesRouterProtocol?
    
    private var movies = [Movie]()
    
    private var paginationEnabled = false
    
    private var nextPage = 1
    
    private var skeletonEnabled = false {
        didSet {
            skeletonEnabled ? view?.showSkeleton() : view?.hideSkeleton()
        }
    }
    
    func viewDidLoad() {
        skeletonEnabled = true
        interactor?.fetchMovies(page: nextPage, includingCache: true)
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getMovie(with index: Int) -> Movie {
        return movies[index]
    }
    
    func showDetailForMovie(with index: Int) {
        if skeletonEnabled { return }
        router?.presentDetailView(from: view!, for: movies[index])
    }
    
    func paginate() {
        guard paginationEnabled else { return }
        paginationEnabled = false
        interactor?.fetchMovies(page: nextPage, includingCache: true)
    }
    
    func didFinishInsertItems() {
        paginationEnabled = true
    }
    
    func startReloading() {
        nextPage = 1
        paginationEnabled = false
        interactor?.fetchMovies(page: nextPage, includingCache: false)
    }
    
    func didReceiveMemoryWarning() {
        movies.forEach { movie in
            movie.posterImage = nil
        }
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    
    func didFetchMovies(_ movies: [Movie], cache: Bool) {
        if skeletonEnabled {
            skeletonEnabled = false
        }
        if nextPage == 1 {
            view?.endReloading()
        }
        guard !movies.isEmpty else {
            paginationEnabled = false
            if nextPage == 1 {
                self.movies.removeAll()
                view?.reloadData()
                view?.showNoMoviesMessage()
            }
            return
        }
        if nextPage == 1 {
            self.movies = movies
            view?.reloadData()
            view?.hideNoMoviesMessage()
            paginationEnabled = !cache
        } else {
            let fromIndex = self.movies.count
            self.movies += movies
            view?.insertItems(at: fromIndex..<self.movies.count)
        }
        if !cache {
            nextPage += 1
        }
    }
    
    func onError() {
        view?.showError()
        paginationEnabled = true
    }
}
