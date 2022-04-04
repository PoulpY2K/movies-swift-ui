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
    
    let cellReuseId: String = "MovieCellReuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
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
let movies: [Movie] = [Movie(titre: "Shrek", sous_titre: "Shrek: Les Origines", date_sortie: "4 Jul 2001", duree_film: TimeInterval(5_400), categories: ["Fantastique", "Action", "Aventure"], synopsis: "Il était une fois, dans un marais lointain, un ogre au nom de Shrek qui voit sa précieuse solitude brisée pas une invasion de personnages de contes de fées agaçants. Ils ont tous été bannis de leur royaume par le méchant Lord Farquaad.", affiche: "shrek_affiche", poster: "shrek_poster", trailer_lien: URL(string: "https://www.youtube.com/watch?v=CwXOrWvPBPk")!), Movie(titre: "Le Chat Potté", sous_titre: "Un chat pas comme les autres", date_sortie: "11 Sep 2011", duree_film: TimeInterval(5_900), categories: ["Drame", "Action", "Avion"], synopsis: "Il était une fois, deux tours surplombant New York. Mais un beau jour, un avion a décidé de se planter dedans. Mais le Chat Potté est apparu pour sauver tous les humains et l'histoire s'est bien terminée.", affiche: "chat_potte", poster: "shrek_poster", trailer_lien: URL(string: "https://www.youtube.com/watch?v=hfh2Tk3sXCs")!)]

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! MovieTableViewCell
        
        cell.setupCell(title: movies[indexPath.row].titre, description: movies[indexPath.row].synopsis, date: movies[indexPath.row].date_sortie, image: UIImage(imageLiteralResourceName: movies[indexPath.row].affiche))
        return cell
    }
    
    
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(movies[indexPath.row])
        let swiftUIView = MoviesDetailsView(movie: movies[indexPath.row])
        let hostVC = UIHostingController(rootView: swiftUIView)

        present(hostVC, animated: true) {
            print("Presented")
        }
    }
}
