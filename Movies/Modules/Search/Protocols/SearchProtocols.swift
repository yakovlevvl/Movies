//
//  SearchProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    
    var presenter: SearchPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func reloadData()
    
    func showError()
}

protocol SearchPresenterProtocol: class {
    
    var view: SearchViewProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
}

protocol SearchRouterProtocol: class {
    
    static func createSearchModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentDetailView(from view: SearchViewProtocol)
}
