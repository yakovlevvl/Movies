//
//  PopularLocalDataManager.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/23/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class PopularLocalDataManager: PopularLocalDataManagerInputProtocol {
    
    var cacheUrl: URL {
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let cacheUrl = documentUrl.appendingPathComponent("popularCache")
        return cacheUrl
    }
    
    func fetchMovies() -> [Movie]? {
        do {
            let data = try Data(contentsOf: cacheUrl)
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            print(movies)
            return movies
        } catch {
            return nil
        }
    }
    
    func cacheMovies(_ movies: [Movie]) {
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: cacheUrl)
        } catch {
            print("cache popular movies error")
        }
    }
}
