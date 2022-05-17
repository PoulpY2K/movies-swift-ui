//
//  GenreViewController.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import UIKit
import SwiftUI

class GenreViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genreViewModel = GenreViewModel()
    
    let cellReuseId: String = "GenreCellReuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// On transforme le layout via un unwrap afin de pouvoir l'utiliser pour réduire le nombre de colonnes dans la CollectionView
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            /// Affichage des catégories en fonction de la taille d'écran
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            let screenWidth = UIScreen.main.bounds.size.width
            flowLayout.itemSize = CGSize(width: screenWidth/2 - 10, height: screenWidth/2 - 40)
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 10
            
        }
        
        collectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseId)
        
        /// Récupération des catégories
        genreViewModel.getGenres { [self] in
            self.collectionView.reloadData()
        }
    }
    
}

extension GenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreViewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! GenreCollectionViewCell
        
        /// Permet de mettre un gradiant aléatoire en fond des catégories
        let gradient = CAGradientLayer()
        gradient.frame = cell.bounds
        gradient.colors = [UIColor(
            red: .random(in: 0...0.7),
            green: .random(in: 0...0.7),
            blue: .random(in: 0...0.7), alpha: CGFloat(1)
        ).cgColor, UIColor(
            red: .random(in: 0...0.7),
            green: .random(in: 0...0.7),
            blue: .random(in: 0...0.7), alpha: CGFloat(1)
        ).cgColor]
        
        /// Insère le fond gradiant
        cell.layer.insertSublayer(gradient, at: 0)
        
        cell.setupCell(title: genreViewModel.genres[indexPath.row].name)
        return cell
    }
}

extension GenreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let swiftUIView = MovieViewController()
        /// On passe l'ID de la catégorie au MovieViewController lors de son init
        swiftUIView.genreId = genreViewModel.genres[indexPath.row].id
        
        /// On navigue sur le MovieViewController
        self.navigationController?.pushViewController(swiftUIView, animated: true)
    }
}
