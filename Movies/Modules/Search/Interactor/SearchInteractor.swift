//
//  SearchInteractor.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class SearchInteractor: SearchInteractorInputProtocol {
    
    weak var presenter: SearchInteractorOutputProtocol?
    var remoteDataManager: SearchRemoteDataManagerInputProtocol?
    
    func fetchResults(for searchText: String, page: Int) {
        remoteDataManager?.fetchResults(for: searchText, page: page)
    }
    
    func cancelFetching() {
        remoteDataManager?.cancelFetching()
    }
}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    
    func onResultsFetched(_ results: [Movie]) {
        presenter?.didFetchResults(results)
    }
    
    func onError() {
        presenter?.onError()
    }
}
