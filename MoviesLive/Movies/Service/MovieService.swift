//
//  MovieService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 05/04/2022.
//

import Foundation

class MovieService {
    func loadGenreMovies(genreId: Int, completion: @escaping ([Movie]) -> ()) {
        guard let moviesURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=97c9243f1e93077660701f0bae3394b9&with_genres=\(genreId)") else { return };
        
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
    
    func loadMovieDetails(movieId: Int, completion: @escaping (MovieDetails?) -> ()) {
        guard let moviesURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=97c9243f1e93077660701f0bae3394b9&language=fr-FR") else { return };
        
        URLSession.shared.dataTask(with: moviesURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var movieDetails: MovieDetails? = nil
            let decoder = JSONDecoder()
            
            do {
                movieDetails = try decoder.decode(MovieDetails.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(movieDetails)
            }
        }.resume()
    }
    
    func loadMovieVideoLink(movieId: Int, completion: @escaping (MovieVideo?) -> ()) {
        guard let moviesVideosURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=97c9243f1e93077660701f0bae3394b9&language=fr-FR") else { return };
        
        URLSession.shared.dataTask(with: moviesVideosURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var movieVideoPage: MovieVideoPage? = nil
            let decoder = JSONDecoder()
            
            do {
                movieVideoPage = try decoder.decode(MovieVideoPage.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                if let finalMovieVideoPage = movieVideoPage {
                    if(finalMovieVideoPage.results.count > 0) {
                        completion(finalMovieVideoPage.results[0])
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
