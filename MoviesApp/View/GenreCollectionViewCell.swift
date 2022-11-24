//
//  GenreCollectionViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        genreLabel.layer.borderColor = UIColor.lightGray.cgColor
        genreLabel.layer.borderWidth = 0.5
    }
    
    func configure(with genre: String) {
        genreLabel.text = genre
    }
}
