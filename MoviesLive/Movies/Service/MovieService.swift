//
//  MovieService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 05/04/2022.
//

import Foundation

class MovieService {
    func loadPopularMovies(completion: @escaping ([Movie]) -> ()) {
        guard let moviesURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=97c9243f1e93077660701f0bae3394b9") else { return };
        
        URLSession.shared.dataTask(with: moviesURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var movies: [Movie] = []
            
            let decoder = JSONDecoder()
            
            do {
                movies = try decoder.decode(MoviePage.self, from: data).results
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
    
    func loadMovieDetails(movieId: String, completion: @escaping (MovieDetails?) -> ()) {
        guard let moviesURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=97c9243f1e93077660701f0bae3394b9") else { return };
        
        URLSession.shared.dataTask(with: moviesURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var movieDetails: MovieDetails? = nil
            let decoder = JSONDecoder()
            
            do {
                movieDetails = try decoder.decode(MovieDetails.self, from: data)
                print(movieDetails)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(movieDetails)
            }
        }.resume()
    }
}
