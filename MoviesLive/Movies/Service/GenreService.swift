//
//  GenreService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import Foundation

class GenreService {
    func loadGenresList(completion: @escaping ([Genre]) -> ()) {
        guard let genresURL = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=97c9243f1e93077660701f0bae3394b9") else { return };
        
        URLSession.shared.dataTask(with: genresURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var genres: [Genre] = []
            
            let decoder = JSONDecoder()
            
            do {
                genres = try decoder.decode([Genre].self, from: data)
                print(genres)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(genres)
            }
        }.resume()
    }
}
