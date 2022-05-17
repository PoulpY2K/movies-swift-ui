//
//  MovieViewController.swift
//  MoviesLive
//
//  Created by Digital on 04/04/2022.
//

import UIKit
import SwiftUI

class MovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var movieViewModel = MovieViewModel()
    
    var genreId: Int?
    
    let cellReuseId: String = "MovieCellReuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
        
        /// On vérifie que l'id de la catégorie est bien présent, puis on récupère les films avant de rafraîchir
        /// les cellules
        if let idGenre = self.genreId {
            movieViewModel.getMovies(genreId: idGenre) {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! MovieTableViewCell
        
        cell.setupCell(title: movieViewModel.movies[indexPath.row].title, description: movieViewModel.movies[indexPath.row].overview, date: movieViewModel.movies[indexPath.row].release_date, image: movieViewModel.imageURL + movieViewModel.movies[indexPath.row].poster_path)
        return cell
    }
    
    
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieId: Int = movieViewModel.movies[indexPath.row].id
        
        /// On récupère plus de détail sur le film sur lequel on clique
        movieViewModel.getMovieDetails(movieId: movieId) { [self] movie in
            
            /// On unwrap le film pour s'assurer qu'il est bien présent
            if let finalMovie = movie {
                
                /// On récupère la clef de la vidéo YT du trailer du film
                movieViewModel.getMovieVideo(movieId: movieId) { [self] movieVideo in
                    let swiftUIView = MoviesDetailsView(movie: finalMovie, video_key: movieVideo?.key)
                    let hostVC = UIHostingController(rootView: swiftUIView)
                    
                    present(hostVC, animated: true) {
                    }
                }
            } else {
                /// Implémenter un toaster afin de prévenir l'utilisateur (package externe donc non implémenté)
                print("Une erreur est survenue !")
            }
        }
    }
}
