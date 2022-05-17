//
//  MovieService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 05/04/2022.
//

import Foundation

class MovieService {
    /// Récupère les films par catégorie
    func loadGenreMovies(genreId: Int, completion: @escaping ([Movie]) -> ()) {
        guard let moviesURL = URL(string: K.MovieApi.moviesPerGenreUrl + String(genreId)) else { return };
        
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
    
    /// Récupère les détails d'un film
    func loadMovieDetails(movieId: Int, completion: @escaping (MovieDetails?) -> ()) {
        guard let moviesURL = URL(string: "\(K.movieApiBaseUrl)/\(movieId)?api_key=\(K.apiKey)&language=fr-FR") else { return };
        
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
    
    /// Récupère la clef de la vidéo YouTube du film passé en paramètre
    func loadMovieVideoLink(movieId: Int, completion: @escaping (MovieVideo?) -> ()) {
        guard let moviesVideosURL = URL(string: "\(K.movieApiBaseUrl)/\(movieId)/videos?api_key=\(K.apiKey)&language=fr-FR") else { return };
        
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
                /// On vérifie que le film possède bien une vidéo avant de compléter, sinon renvoie vide
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
