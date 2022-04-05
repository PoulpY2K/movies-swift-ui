//
//  Movie.swift
//  MoviesLive
//
//  Created by Digital on 29/03/2022.
//

import Foundation

struct Movie: Codable {
    let titre: String
    let sous_titre: String
    let date_sortie: String
    let duree_film: TimeInterval
    let categories: [String]
    let synopsis: String
    var affiche: String
    var poster: String
    var trailer_lien: URL
}
