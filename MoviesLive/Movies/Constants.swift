//
//  Constants.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import Foundation

/// Constantes de l'application
struct K {
    
    // CLEF DE L'API TMDB À MODIFIER AVEC LA VOTRE !
    static let apiKey: String = "97c9243f1e93077660701f0bae3394b9"
    
    static let movieApiBaseUrl: String = "https://api.themoviedb.org/3/movie"
    static let genreApiBaseUrl: String = "https://api.themoviedb.org/3/genre"
    
    static let TMDBImageURL: String = "https://image.tmdb.org/t/p/original"
    static let youtubeURL: String = "https://www.youtube.com/watch?v="
    
    struct MovieApi {
        static let moviesPerGenreUrl: String = "\(movieApiBaseUrl)/popular?api_key=\(apiKey)&language=fr-FR&with_genres="
        
    }
    
    struct GenreApi {
        static let genresListUrl: String = "\(genreApiBaseUrl)/movie/list?api_key=\(apiKey)&language=fr-FR"
    }
}
