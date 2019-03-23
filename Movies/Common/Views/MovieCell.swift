//
//  MovieCell.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/23/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    static let reuseId = "MovieCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenir, size: 19)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame.size.width = bounds.width - 40
        titleLabel.frame.size.height = bounds.height
        
        titleLabel.center = contentView.center
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
