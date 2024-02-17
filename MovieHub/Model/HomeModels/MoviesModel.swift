//
//  MoviesModel.swift
//  MovieHub
//
//  Created by Mahmudullah on 17/2/24.
//

import Foundation

struct GetMoviesWrapper: Codable {
    var results: [MovieModel] = []
    
    enum CodingKeys: CodingKey {
        case results
    }
}

struct MovieModel: Codable {
    var id: Int?
    var overview: String?
    var poster_path: String?
    var title: String?
    
    enum CodingKeys: CodingKey {
        case id, overview, poster_path, title
    }
}
