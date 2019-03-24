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
        label.font = UIFont(name: Fonts.avenir, size: 18)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenirMedium, size: 16)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Fonts.avenirMedium, size: 16)
        return label
    }()
    
    private let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Colors.placeholder
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let posterRatio: CGFloat = 0.67
        posterView.frame.size.height = bounds.height - 40
        posterView.frame.size.width = posterView.frame.height*posterRatio
        posterView.frame.origin.x = 20
        posterView.center.y = bounds.height/2
        
        titleLabel.frame.origin.x = posterView.frame.maxX + 16
        titleLabel.frame.size.width = bounds.width - titleLabel.frame.minX - 20
        titleLabel.frame.origin.y = posterView.frame.minY + 4
        titleLabel.frame.size.height = 20
        
        dateLabel.frame.origin.x = titleLabel.frame.minX
        dateLabel.frame.size.width = titleLabel.frame.width
        dateLabel.frame.origin.y = titleLabel.frame.maxY + 12
        dateLabel.frame.size.height = 20
        
        overviewLabel.frame.origin.x = titleLabel.frame.minX
        overviewLabel.frame.size.width = titleLabel.frame.width
        overviewLabel.frame.origin.y = dateLabel.frame.maxY + 6
        overviewLabel.frame.size.height = posterView.frame.maxY - overviewLabel.frame.minY
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.image = nil
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setOverview(_ overview: String) {
        overviewLabel.text = overview
    }
    
    func setDate(_ date: String) {
        dateLabel.text = date
    }
    
    func setPoster(_ image: UIImage?) {
        posterView.image = image
    }
    
    func showSkeleton() {
        titleLabel.backgroundColor = Colors.placeholder
        overviewLabel.backgroundColor = Colors.placeholder
        dateLabel.backgroundColor = Colors.placeholder
    }
    
    func hideSkeleton() {
        titleLabel.backgroundColor = .clear
        overviewLabel.backgroundColor = .clear
        dateLabel.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
