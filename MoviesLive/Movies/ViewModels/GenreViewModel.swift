//
//  GenreViewModel.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import Foundation

class GenreViewModel {
    var genres: [Genre] = []
    
    func getGenres(completion: @escaping () -> ()) {
        GenreService().loadGenresList() { genres in
            self.genres = genres
            completion()
        }
    }
}
