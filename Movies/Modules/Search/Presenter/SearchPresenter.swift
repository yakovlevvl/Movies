//
//  SearchPresenter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {

    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    private var results = [Movie]()
    
    private var paginationEnabled = false
    
    private var nextPage = 1
    
    private var searchText = ""
    
    private var skeletonEnabled = false {
        didSet {
            skeletonEnabled ? view?.showSkeleton() : view?.hideSkeleton()
        }
    }
    
    func getMoviesCount() -> Int {
        return results.count
    }
    
    func getMovie(with index: Int) -> Movie {
        return results[index]
    }
    
    func showDetailForMovie(with index: Int) {
        router?.presentDetailView(from: view!, for: results[index])
    }
    
    func paginate() {
        guard paginationEnabled else { return }
        paginationEnabled = false
        interactor?.fetchResults(for: searchText, page: nextPage)
    }
    
    func didFinishInsertItems() {
        paginationEnabled = true
    }
    
    func updateSearchResults(for searchText: String) {
        nextPage = 1
        paginationEnabled = false
        let text = searchText.trimmingCharacters(in: .whitespaces)
        if text == self.searchText { return }
        self.searchText = text
        if text.isEmpty {
            results.removeAll()
            view?.reloadData()
            view?.hideNoMoviesMessage()
            if skeletonEnabled {
                skeletonEnabled = false
            }
        } else {
            skeletonEnabled = true
            interactor?.fetchResults(for: text, page: nextPage)
        }
    }
    
    func didReceiveMemoryWarning() {
        results.forEach { movie in
            movie.posterImage = nil
        }
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func didFetchResults(_ results: [Movie]) {
        if skeletonEnabled {
            skeletonEnabled = false
        }
        guard !results.isEmpty else {
            paginationEnabled = false
            if nextPage == 1 {
                self.results.removeAll()
                view?.reloadData()
                view?.showNoMoviesMessage()
            }
            return
        }
        if nextPage == 1 {
            self.results = results
            view?.reloadData()
            view?.hideNoMoviesMessage()
            paginationEnabled = true
        } else {
            let fromIndex = self.results.count
            self.results += results
            view?.insertItems(at: fromIndex..<self.results.count)
        }
        nextPage += 1
    }
    
    func onError() {
        view?.showError()
        paginationEnabled = true
    }
}
