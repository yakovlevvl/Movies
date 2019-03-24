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
}

extension DetailInteractor: DetailRemoteDataManagerOutputProtocol {
    
    func onDetailsFetched(for movie: Movie) {
        presenter?.didFetchDetails(for: movie)
    }
    
    func onError() {
        presenter?.onError()
    }
}
