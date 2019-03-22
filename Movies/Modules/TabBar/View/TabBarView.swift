//
//  TabBarView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class TabBarView: UITabBarController {
    
    var presenter: TabBarPresenterProtocol?
}

extension TabBarView: TabBarViewProtocol {
    
}
