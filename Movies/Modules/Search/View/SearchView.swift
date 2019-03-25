//
//  SearchView.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/22/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class SearchView: UICollectionViewController {
    
    var presenter: SearchPresenterProtocol?
    
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
        
        view.backgroundColor = .white
        navigationController?.view.backgroundColor = .white
        collectionView.backgroundColor = Colors.gray
        navigationItem.title = "Search"
        
        let backItem = UIBarButtonItem()
        backItem.title = "Search"
        backItem.setTitleTextAttributes([.font: UIFont(name: Fonts.avenir, size: 18)!], for: .normal)
        navigationItem.backBarButtonItem = backItem
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.isActive = true
        definesPresentationContext = true
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
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

extension SearchView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter!.getMoviesCount()
        collectionView.backgroundColor = count == 0 && !skeletonEnabled ? .white : Colors.gray
        return !skeletonEnabled ? count : 6
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

extension SearchView: UICollectionViewDelegateFlowLayout {
    
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

extension SearchView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.updateSearchResults(for: searchController.searchBar.text!)
    }
}

extension SearchView: SearchViewProtocol {
    
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
        print("SearchView Error")
    }
}
