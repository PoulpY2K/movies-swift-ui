//
//  GenreService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import Foundation

class GenreService {
    /// Récupère la liste des catégories de films
    func loadGenresList(completion: @escaping ([Genre]) -> ()) {
        guard let genresURL = URL(string: K.GenreApi.genresListUrl) else { return };
        
        URLSession.shared.dataTask(with: genresURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            var genres: [Genre] = []
            
            let decoder = JSONDecoder()
            
            do {
                genres = try decoder.decode(GenrePage.self, from: data).genres
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(genres)
            }
        }.resume()
    }
}
