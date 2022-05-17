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
        // Do any additional setup after loading the view.
        
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
        
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
        
        movieViewModel.getMovieDetails(movieId: movieId) { [self] movie in
            if let finalMovie = movie {
                movieViewModel.getMovieVideo(movieId: movieId) { [self] movieVideo in
                    let swiftUIView = MoviesDetailsView(movie: finalMovie, video_link: movieVideo?.key)
                    let hostVC = UIHostingController(rootView: swiftUIView)
                    
                    present(hostVC, animated: true) {
                    }
                }
            } else {
                // Implémenter un toaster afin de prévenir l'utilisateur
                print("Une erreur est survenue !")
            }
        }
    }
}
