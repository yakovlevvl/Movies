//
//  DetailView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/24/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class DetailView: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenir, size: 19)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenirMedium, size: 17)
        return label
    }()
    
    private let budgetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenirMedium, size: 17)
        label.text = "Budget"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenirMedium, size: 17)
        label.text = "Rating"
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.avenirMedium, size: 17)
        label.text = "Country"
        return label
    }()
    
    private let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Fonts.avenirMedium, size: 17)
        return textView
    }()
    
    private let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Colors.placeholder
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie"
        
        let favoriteButton = UIButton(type: .custom)
        favoriteButton.setImage(UIImage(named: "FavoritesIcon"), for: .normal)
        favoriteButton.contentMode = .center
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        let favoriteItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = favoriteItem
        
        view.addSubview(scrollView)
        scrollView.addSubview(posterView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(overviewTextView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(budgetLabel)
        stackView.addArrangedSubview(ratingLabel)
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let posterRatio: CGFloat = 0.67
        posterView.frame.size.height = 180
        posterView.frame.size.width = posterView.frame.height*posterRatio
        posterView.frame.origin.x = 20
        posterView.frame.origin.y = 20
        
        stackView.frame.origin.x = posterView.frame.maxX + 16
        stackView.frame.size.width = view.frame.width - stackView.frame.minX - 20
        stackView.frame.origin.y = posterView.frame.minY
        stackView.frame.size.height = posterView.frame.height
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.setCustomSpacing(6, after: titleLabel)
        
        overviewTextView.frame.origin.y = posterView.frame.maxY + 20
        overviewTextView.frame.size.width = view.frame.width - 2*posterView.frame.minX
        overviewTextView.center.x = view.center.x
        overviewTextView.sizeToFit()
        
        scrollView.contentSize.height = overviewTextView.frame.maxY + 20
    }
    
    @objc private func didTapFavoriteButton() {
        presenter?.didTapFavoriteButton()
    }
}

extension DetailView: DetailViewProtocol {
    
    func update(for movie: Movie) {
        posterView.image = movie.posterImage
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movie.date)!
        dateFormatter.dateStyle = .medium
        dateLabel.text = dateFormatter.string(from: date)
        
        countryLabel.text = movie.country ?? "Country"
        
        if let budget = movie.budget {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "en_US")
            let string = formatter.string(from: budget as NSNumber)
            budgetLabel.text = string
        }
        
        if let rating = movie.rating {
            ratingLabel.text = "\(rating)/10"
        }
        
        view.setNeedsLayout()
    }
    
    func showError() {
        print("detailView update error")
    }
}
