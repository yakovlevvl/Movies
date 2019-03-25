//
//  FavoritesInteractor.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class FavoritesInteractor: FavoritesInteractorInputProtocol {
    
    weak var presenter: FavoritesInteractorOutputProtocol?
    var localDataManager: FavoritesLocalDataManagerInputProtocol?
    var remoteDataManager: FavoritesRemoteDataManagerInputProtocol?
    
    func fetchMovies(page: Int, includingCache: Bool) {
        if includingCache, page == 1, let movies = localDataManager?.fetchMovies() {
            presenter?.didFetchMovies(movies, cache: true)
        }
        remoteDataManager?.fetchMovies(page: page)
    }
}

extension FavoritesInteractor: FavoritesRemoteDataManagerOutputProtocol {
    
    func onMoviesFetched(_ movies: [Movie], page: Int) {
        presenter?.didFetchMovies(movies, cache: false)
        
        if page == 1 {
            localDataManager?.cacheMovies(movies)
        }
    }
    
    func onError() {
        presenter?.onError()
    }
}
