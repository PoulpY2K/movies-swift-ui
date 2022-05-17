//
//  MovieViewModel.swift
//  MoviesLive
//
//  Created by Digital on 05/04/2022.
//

import Foundation

class MovieViewModel {
    var movies: [Movie] = []
    var imageURL: String = "https://image.tmdb.org/t/p/original"
    
    func getMovies(completion: @escaping () -> ()) {
        MovieService().loadPopularMovies() { movies in 
            self.movies = movies
            completion()
        }
    }
    
    func getMovieDetails(movieId: String, completion: @escaping (MovieDetails?) -> ()) {
        MovieService().loadMovieDetails(movieId: movieId) { movieDetails in
            completion(movieDetails)
        }
    }
    
    
}
