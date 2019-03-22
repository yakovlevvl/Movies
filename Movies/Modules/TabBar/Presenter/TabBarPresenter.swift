//
//  TabBarPresenter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class TabBarPresenter: TabBarPresenterProtocol {
    
    weak var view: TabBarViewProtocol?
    
    var router: TabBarRouterProtocol?
}
