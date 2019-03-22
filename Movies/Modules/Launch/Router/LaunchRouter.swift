//
//  LaunchRouter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/21/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class LaunchRouter: LaunchRouterProtocol {
    
    static func createLaunchModule() -> UIViewController {
        let view: LaunchViewProtocol = LaunchView()
        let presenter: LaunchPresenterProtocol = LaunchPresenter()
        let router: LaunchRouterProtocol = LaunchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return view as! UIViewController
    }
    
    func presentTabBarView(from view: LaunchViewProtocol) {
        let tabBarViewController = TabBarRouter.createTabBarModule()
        UIApplication.shared.keyWindow?.rootViewController = tabBarViewController
    }
}
