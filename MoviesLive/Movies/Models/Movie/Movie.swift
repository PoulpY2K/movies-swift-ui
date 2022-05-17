//
//  Movie.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 29/03/2022.
//

import Foundation

struct Movie: Codable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let release_date: String
}
