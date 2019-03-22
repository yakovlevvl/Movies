//
//  PopularProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol PopularViewProtocol: class {
    
    var presenter: PopularPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func reloadData()
    
    func showError()
}

protocol PopularPresenterProtocol: class {
    
    var view: PopularViewProtocol? { get set }
    var router: PopularRouterProtocol? { get set }
}

protocol PopularRouterProtocol: class {
    
    static func createPopularModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentDetailView(from view: PopularViewProtocol)
}
