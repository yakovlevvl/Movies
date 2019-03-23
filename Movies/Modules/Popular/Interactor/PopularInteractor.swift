//
//  PopularInteractor.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/23/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class PopularInteractor: PopularInteractorInputProtocol {
    
    weak var presenter: PopularInteractorOutputProtocol?
    var localDataManager: PopularLocalDataManagerInputProtocol?
    var remoteDataManager: PopularRemoteDataManagerInputProtocol?
    
    func fetchMovies(page: Int) {
        remoteDataManager?.fetchMovies(page: page)
    }

}

extension PopularInteractor: PopularRemoteDataManagerOutputProtocol {
    
    func onMoviesFetched(_ movies: [Movie]) {
        presenter?.didFetchMovies(movies)
        
        // cache movies
    }
    
    func onError() {
        presenter?.onError()
    }
}
