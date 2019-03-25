//
//  DetailInteractor.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/24/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class DetailInteractor: DetailInteractorInputProtocol {
    
    weak var presenter: DetailInteractorOutputProtocol?
    
    var remoteDataManager: DetailRemoteDataManagerInputProtocol?
    
    func fetchDetails(for movie: Movie) {
        remoteDataManager?.fetchDetails(for: movie)
    }
    
    func addToFavorites(movie: Movie) {
        remoteDataManager?.addToFavorites(movie: movie)
    }
}

extension DetailInteractor: DetailRemoteDataManagerOutputProtocol {
    
    func onDetailsFetched(for movie: Movie) {
        presenter?.didFetchDetails(for: movie)
    }
    
    func onAddToFavoritesSuccess(_ movie: Movie) {
        presenter?.didAddToFavorites(movie: movie)
    }
    
    func onAddToFavoritesError() {
        presenter?.onAddToFavoritesError()
    }
    
    func onFetchError() {
        presenter?.onFetchError()
    }
}
