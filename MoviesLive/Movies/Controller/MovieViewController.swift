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
    
    var _movieViewModel = MovieViewModel()
    
    let cellReuseId: String = "MovieCellReuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
        
        _movieViewModel.getMovies(){
            self.tableView.reloadData()
        }
        
        
    }
    
    @IBAction func presentNextAction(_ sender: Any) {
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! MovieTableViewCell
        
        cell.setupCell(title: _movieViewModel.movies[indexPath.row].title, description: _movieViewModel.movies[indexPath.row].overview, date: _movieViewModel.movies[indexPath.row].release_date, image: _movieViewModel.imageURL + _movieViewModel.movies[indexPath.row].poster_path)
        return cell
    }
    
    
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let swiftUIView = MoviesDetailsView(movie: _movieViewModel.movies[indexPath.row])
        let hostVC = UIHostingController(rootView: swiftUIView)
        
        present(hostVC, animated: true) {
            print("Presented")
        }
    }
}
