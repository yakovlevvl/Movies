//
//  FavoritesProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol FavoritesViewProtocol: class {
    
    var presenter: FavoritesPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func reloadData()
    
    func showError()
}

protocol FavoritesPresenterProtocol: class {
    
    var view: FavoritesViewProtocol? { get set }
    var router: FavoritesRouterProtocol? { get set }
}

protocol FavoritesRouterProtocol: class {
    
    static func createFavoritesModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentDetailView(from view: FavoritesViewProtocol)
}
