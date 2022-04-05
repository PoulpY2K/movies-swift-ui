//
//  MovieService.swift
//  MoviesLive
//
//  Created by Digital on 05/04/2022.
//

import Foundation

class MovieService {
    func loadMovies(forKindId: String, completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/76341?api_key=97ddd43b8c8d344a735337d0bf8ceac9") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let movies = try! JSONDecoder().decode([Movie].self, from: data!)
            print(movies)
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
}
