//
//  LaunchProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/21/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol LaunchViewProtocol: class {
    
    var presenter: LaunchPresenterProtocol? { get set }
    
    // Presenter -> View
    
    func showAnimation()
}

protocol LaunchPresenterProtocol: class {
    
    var view: LaunchViewProtocol? { get set }
    var router: LaunchRouterProtocol? { get set }
    
    // View -> Presenter
    
    func viewDidLoad()
}

protocol LaunchRouterProtocol: class {
    
    static func createLaunchModule() -> UIViewController
    
    // Presenter -> Router
    
    func presentTabBarView(from view: LaunchViewProtocol)
}
