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
    
    func getMovies(genreId: Int, completion: @escaping () -> ()) {
        MovieService().loadGenreMovies(genreId: genreId) { movies in
            self.movies = movies
            completion()
        }
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping (MovieDetails?) -> ()) {
        MovieService().loadMovieDetails(movieId: movieId) { movieDetails in
            completion(movieDetails)
        }
    }
    
    func getMovieVideo(movieId: Int, completion: @escaping (MovieVideo?) -> ()) {
        MovieService().loadMovieVideoLink(movieId: movieId) { movieVideo in
            completion(movieVideo)
        }
    }
    
}
