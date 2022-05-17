//
//  MovieDetails.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import Foundation

struct MovieDetails: Codable, Equatable {
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let genres: [Genre]
    let backdrop_path: String
    let poster_path: String
    let release_date: String
    let runtime: Int
    let video: Bool
}
