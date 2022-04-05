//
//  MovieViewModel.swift
//  MoviesLive
//
//  Created by Digital on 05/04/2022.
//

import Foundation

class MovieViewModel {
    var movies: [Movie] = []
    
    func getMovies(completion: @escaping (() -> ())) {
        MovieService().loadMovies(forKindId: "") { movies in
            self.movies = movies
            completion()
        }
    }
}
