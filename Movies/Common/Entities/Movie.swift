//
//  Movie.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/23/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import Foundation

final class Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let date: String
    let posterPath: String?
    
    var budget: Int?
    var rating: Double?
    var country: String?
    
    var posterUrl: URL? {
        guard let path = posterPath else {
            return nil
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        return url
    }
    
    init(id: Int, title: String, overview: String, date: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.date = date
        self.posterPath = posterPath
    }
}
