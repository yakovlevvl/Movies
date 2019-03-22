//
//  TabBarRouter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class TabBarRouter: TabBarRouterProtocol {
    
    static func createTabBarModule() -> UIViewController {
        let view: TabBarViewProtocol = TabBarView()
        let presenter: TabBarPresenterProtocol = TabBarPresenter()
        let router: TabBarRouterProtocol = TabBarRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        var viewControllers = [UIViewController]()
        
        // PopularViewController
        
        let popularViewController = PopularRouter.createPopularModule()
        let popularNavController = UINavigationController(rootViewController: popularViewController)
        let popularBarItem = UITabBarItem()
        popularBarItem.image = UIImage(named: "PopularIcon")
        popularBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        popularNavController.tabBarItem = popularBarItem
        viewControllers.append(popularNavController)
        
        // FavoritesViewController
        
        let favoritesViewController = FavoritesRouter.createFavoritesModule()
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        let favoritesBarItem = UITabBarItem()
        favoritesBarItem.image = UIImage(named: "FavoritesIcon")
        favoritesBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        favoritesNavController.tabBarItem = favoritesBarItem
        viewControllers.append(favoritesNavController)
        
        // SearchViewController
        
        let searchViewController = SearchRouter.createSearchModule()
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        let searchBarItem = UITabBarItem()
        searchBarItem.image = UIImage(named: "SearchIcon")
        searchBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        searchNavController.tabBarItem = searchBarItem
        viewControllers.append(searchNavController)
        
        let tabBarController = view as! UITabBarController
        tabBarController.viewControllers = viewControllers
        
        return tabBarController
    }
}
