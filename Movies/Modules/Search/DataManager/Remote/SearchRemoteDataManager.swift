//
//  SearchRemoteDataManager.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/25/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class SearchRemoteDataManager: SearchRemoteDataManagerInputProtocol {
    
    weak var interactor: SearchRemoteDataManagerOutputProtocol?
    
    func fetchResults(for searchText: String, page: Int) {
        let searchText = searchText.replacingOccurrences(of: " ", with: "+", options: .literal)
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(Api.key)&language=en-US&query=\(searchText)&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            return DispatchQueue.main.async {
                self.interactor?.onError()
            }
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return DispatchQueue.main.async {
                    self.interactor?.onError()
                }
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data)) as? Json,
                let resultsJson = json["results"] as? [Json] else {
                    return DispatchQueue.main.async {
                        self.interactor?.onError()
                    }
            }
            
            var movies = [Movie]()
            
            for resultJson in resultsJson {
                guard let id = resultJson["id"] as? Int,
                    let title = resultJson["title"] as? String,
                    let overview = resultJson["overview"] as? String,
                    let date = resultJson["release_date"] as? String else {
                        continue
                }
                
                let posterPath = resultJson["poster_path"] as? String
                
                let movie = Movie(id: id, title: title, overview: overview, date: date, posterPath: posterPath)
                
                movies.append(movie)
            }
            
            DispatchQueue.main.async {
                self.interactor?.onResultsFetched(movies)
            }
            
        }.resume()
    }
}
