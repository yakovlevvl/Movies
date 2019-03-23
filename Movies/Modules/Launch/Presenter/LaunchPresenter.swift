//
//  LaunchPresenter.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/21/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

enum AnimationGroup: CaseIterable {
    
    case A
    
    case B
}

final class LaunchPresenter: LaunchPresenterProtocol {
    
    weak var view: LaunchViewProtocol?
    
    var router: LaunchRouterProtocol?
    
    func viewDidAppear() {
        let randomGroup = AnimationGroup.allCases.randomElement()!
        view?.showAnimation(group: randomGroup)
    }
    
    func animationFinished() {
        router?.presentTabBarView(from: view!)
    }
}
