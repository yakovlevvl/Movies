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
    
    private var skeletonEnabled = false {
        didSet {
            skeletonEnabled ? view?.showSkeleton() : view?.hideSkeleton()
        }
    }
    
    func viewDidLoad() {
        skeletonEnabled = true
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
    
    func didFinishInsertItems() {
        paginationEnabled = true
    }
    
    func didReceiveMemoryWarning() {
        movies.forEach { movie in
            movie.posterImage = nil
        }
    }
}

extension PopularPresenter: PopularInteractorOutputProtocol {
    
    func didFetchMovies(_ movies: [Movie], cache: Bool) {
        if skeletonEnabled {
            skeletonEnabled = false
        }
        guard !movies.isEmpty else {
            paginationEnabled = false
            return
        }
        if nextPage == 1 {
            self.movies = movies
            view?.reloadData()
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
