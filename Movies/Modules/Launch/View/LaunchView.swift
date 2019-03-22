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
    
    private let animatedView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 100, height: 100)
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(animatedView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        animatedView.center = view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }

}

extension LaunchView: LaunchViewProtocol {
    
    func showAnimation(group: AnimationGroup) {
        let duration = 0.2
        let value = view.frame.width/4
        
        UIView.animate(withDuration: duration, animations: {
            self.animatedView.transform = CGAffineTransform(translationX: -value, y: 0)
        }, completion: { finished in
            UIView.animate(withDuration: duration, animations: {
                self.animatedView.transform = self.animatedView.transform.translatedBy(x: 2*value, y: 0)
            }, completion: { finished in
                UIView.animate(withDuration: duration, animations: {
                    self.animatedView.transform = .identity
                }, completion: { finished in
                    self.startAnimation(group: group) {
                        UIView.animate(withDuration: duration, animations: {
                            self.animatedView.backgroundColor = .blue
                        }, completion: { finished in
                            self.presenter?.animationFinished()
                        })
                    }
                })
            })
        })
    }
    
    private func startAnimation(group: AnimationGroup, completion: () -> ()) {
        switch group {
        case .A :
            print("A")
            completion()
            
            
        case .B :
            print("B")
            completion()
            
            
        }
    }

}

extension LaunchView {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
