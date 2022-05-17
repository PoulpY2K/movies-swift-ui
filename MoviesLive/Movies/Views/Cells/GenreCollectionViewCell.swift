//
//  GenreCollectionViewCell.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 17/05/2022.
//

import UIKit
import SwiftUI

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    func setupCell(title: String) {
        titleLabel.text = title
    }
}
