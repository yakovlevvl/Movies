//
//  PopularView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class PopularView: UICollectionViewController {
    
    var presenter: PopularPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = Colors.gray
        navigationItem.title = "Popular"
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
        
        presenter?.viewDidLoad()
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
}

extension PopularView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.getMoviesCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseId, for: indexPath) as! MovieCell
        
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

extension PopularView: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let margin = scrollView.contentSize.height - targetContentOffset.pointee.y
        if margin < 3*view.frame.height {
            presenter?.paginate()
        }
    }
}

extension PopularView: PopularViewProtocol {
    
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

    func reloadData(with animation: Bool) {
        if animation {
            collectionView.reloadSections(IndexSet(integer: 0))
        } else {
            collectionView.reloadData()
        }
    }
    
    func showError() {
        print("PopularView Error")
    }
    
}
