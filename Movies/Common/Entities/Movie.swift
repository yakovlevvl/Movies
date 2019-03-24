//
//  Movie.swift
//  Movies
//
//  Created by Vladyslav Yakovlev on 3/23/19.
//  Copyright © 2019 Vladyslav Yakovlev. All rights reserved.
//

import UIKit

final class Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let date: String
    let posterPath: String?
    
    var budget: Int?
    var rating: Double?
    var country: String?
    
    var posterImage: UIImage?
    
    var posterUrl: URL? {
        guard let path = posterPath else {
            return nil
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(path)")
        return url
    }
    
    var hasDetails: Bool {
        return budget != nil && rating != nil && country != nil
    }
    
    init(id: Int, title: String, overview: String, date: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.date = date
        self.posterPath = posterPath
    }
}

extension Movie {
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case overview
        case date
        case posterPath
    }
}
