//
//  MovieTableViewCell.swift
//  MoviesLive
//
//  Created by Digital on 04/04/2022.
//

import UIKit
import SwiftUI

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        movieImage.image = UIImage(named: "empty")
    }
    
    func setupCell(title: String, description: String, date: String, image: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        dateLabel.text = date
        
        /// On vérifie que l'URL parvient à être construit avant de charger
        /// l'image de manière asynchrone
        if let imageURL = URL(string: image) {
            movieImage.load(url: imageURL, placeholder: UIImage(), cache: nil)
        }
    }
}

