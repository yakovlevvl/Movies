//
//  DetailPresenter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/24/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var router: DetailRouterProtocol?
    
    var movie: Movie!
    
    func viewDidLoad() {
        view?.update(for: movie)
        if !movie.hasDetails {
            interactor?.fetchDetails(for: movie)
        }
    }
    
    func didTapFavoriteButton() {
        interactor?.addToFavorites(movie: movie)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {

    func didFetchDetails(for movie: Movie) {
        view?.update(for: movie)
    }
    
    func didAddToFavorites(movie: Movie) {
        view?.showAddToFavoritesSuccess()
    }
    
    func onAddToFavoritesError() {
        view?.showAddToFavoritesError()
    }
    
    func onFetchError() {
        view?.showFetchError()
    }
}
