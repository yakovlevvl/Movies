//
//  FavoritesView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class FavoritesView: UICollectionViewController {
    
    var presenter: FavoritesPresenterProtocol?
    
    private var skeletonEnabled = false
    
    private lazy var alertView: UILabel = {
        let label = UILabel(frame: collectionView.bounds)
        label.font = UIFont(name: Fonts.avenir, size: 19)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = "No Movies"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = Colors.gray
        navigationItem.title = "Favorites"
        
        let backItem = UIBarButtonItem()
        backItem.title = "Favorites"
        backItem.setTitleTextAttributes([.font: UIFont(name: Fonts.avenir, size: 18)!], for: .normal)
        navigationItem.backBarButtonItem = backItem
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
        
        presenter?.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(startReloading), for: .valueChanged)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize.width = view.frame.width
        layout.itemSize.height = 210
        layout.minimumLineSpacing = 0.5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        presenter?.didReceiveMemoryWarning()
    }
    
    @objc private func startReloading() {
        presenter?.startReloading()
    }
}

extension FavoritesView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !skeletonEnabled ? presenter!.getMoviesCount() : 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseId, for: indexPath) as! MovieCell
        
        if skeletonEnabled {
            cell.showSkeleton()
            return cell
        } else {
            cell.hideSkeleton()
        }
        
        cell.tag += 1
        let tag = cell.tag
        
        let movie = presenter!.getMovie(with: indexPath.item)
        cell.setTitle(movie.title)
        cell.setOverview(movie.overview)
        cell.setDate(movie.date)
        
        if let posterImage = movie.posterImage {
            cell.setPoster(posterImage)
        } else {
            guard let posterUrl = movie.posterUrl else {
                cell.setPoster(nil)
                return cell
            }
            URLSession.getImage(url: posterUrl) { image in
                if let image = image {
                    movie.posterImage = image
                    if cell.tag == tag {
                        cell.setPoster(image)
                    }
                }
            }
        }
        
        return cell
    }
}

extension FavoritesView: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showDetailForMovie(with: indexPath.item)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let margin = scrollView.contentSize.height - targetContentOffset.pointee.y
        if margin < 3*view.frame.height {
            presenter?.paginate()
        }
    }
}

extension FavoritesView: FavoritesViewProtocol {
    
    func insertItems(at indexes: Range<Int>) {
        collectionView.performBatchUpdates({
            let indexPath: [IndexPath] = indexes.map {
                IndexPath(item: $0, section: 0)
            }
            collectionView.insertItems(at: indexPath)
        }, completion: { finished in
            self.presenter?.didFinishInsertItems()
        })
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func endReloading() {
        collectionView.refreshControl?.endRefreshing()
    }
    
    func showSkeleton() {
        skeletonEnabled = true
        collectionView.reloadData()
    }
    
    func hideSkeleton() {
        skeletonEnabled = false
        collectionView.reloadData()
    }
    
    func showNoMoviesMessage() {
        collectionView.backgroundView = alertView
    }
    
    func hideNoMoviesMessage() {
        collectionView.backgroundView = nil
    }
    
    func showError() {
        print("FavoritesView Error")
    }
}
