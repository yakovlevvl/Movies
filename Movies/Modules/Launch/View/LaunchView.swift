//
//  LaunchView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/21/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class LaunchView: UIViewController {

    var presenter: LaunchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
    
    
}

extension LaunchView: LaunchViewProtocol {
    
    func showAnimation() {
        
    }

}
