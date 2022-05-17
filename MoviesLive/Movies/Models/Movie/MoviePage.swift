//
//  MoviePage.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 10/05/2022.
//

import Foundation

struct MoviePage: Codable, Equatable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
