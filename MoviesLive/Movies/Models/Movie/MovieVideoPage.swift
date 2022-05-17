//
//  MovieVideoPage.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import Foundation

struct MovieVideoPage: Codable, Equatable {
    let id: Int
    let results: [MovieVideo]
}
