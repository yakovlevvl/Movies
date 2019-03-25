//
//  DetailRemoteDataManager.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/24/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class DetailRemoteDataManager: DetailRemoteDataManagerInputProtocol {
    
    weak var interactor: DetailRemoteDataManagerOutputProtocol?
    
    func fetchDetails(for movie: Movie) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)?language=en-US&api_key=\(Api.key)"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            guard let data = data, error == nil else {
                return DispatchQueue.main.async {
                    self.interactor?.onFetchError()
                }
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data)) as? Json else {
                return DispatchQueue.main.async {
                    self.interactor?.onFetchError()
                }
            }
            
            guard let budget = json["budget"] as? Int,
                let rating = json["vote_average"] as? Double,
                let countries = json["production_countries"] as? [Json],
                let country = countries.first?["name"] as? String else {
                    return DispatchQueue.main.async {
                        self.interactor?.onFetchError()
                    }
            }
            
            movie.budget = budget
            movie.rating = rating
            movie.country = country
            
            DispatchQueue.main.async {
                self.interactor?.onDetailsFetched(for: movie)
            }
            
        }.resume()
    }
    
    func addToFavorites(movie: Movie) {
        let headers = ["content-type": "application/json;charset=utf-8"]
        let postJson = [
            "media_type": "movie",
            "media_id": movie.id,
            "favorite": true
            ] as Json
        
        let postData = try! JSONSerialization.data(withJSONObject: postJson, options: .prettyPrinted)
        
        let urlString = "https://api.themoviedb.org/3/account/%7Baccount_id%7D/favorite?session_id=\(Api.sessionId)&api_key=\(Api.key)"
        
        var request = URLRequest(url: URL(string: urlString)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 201,
                    error == nil {
                    self.interactor?.onAddToFavoritesSuccess(movie)
                } else {
                    self.interactor?.onAddToFavoritesError()
                }
            }
        }.resume()
    }
}
