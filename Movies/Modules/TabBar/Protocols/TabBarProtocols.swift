//
//  TabBarProtocols.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

protocol TabBarViewProtocol: class {
    
    var presenter: TabBarPresenterProtocol? { get set }
}

protocol TabBarPresenterProtocol: class {
    
    var view: TabBarViewProtocol? { get set }
    var router: TabBarRouterProtocol? { get set }
}

protocol TabBarRouterProtocol: class {
    
    static func createTabBarModule() -> UIViewController
}
