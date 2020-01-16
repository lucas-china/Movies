//
//  Movie.swift
//  Movies
//
//  Created by Lucas Santana Brito on 16/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let title: String?
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title = "title"
        case overview = "overview"
        case backdropPath = "backdrop_path"
    }
}
