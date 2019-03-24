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
                    self.interactor?.onError()
                }
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data)) as? Json else {
                return DispatchQueue.main.async {
                    self.interactor?.onError()
                }
            }
            
            guard let budget = json["budget"] as? Int,
                let rating = json["vote_average"] as? Double,
                let countries = json["production_countries"] as? [Json],
                let country = countries.first?["name"] as? String else {
                    return DispatchQueue.main.async {
                        self.interactor?.onError()
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
}
