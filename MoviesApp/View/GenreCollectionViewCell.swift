//
//  GenreCollectionViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        containerView.layer.borderWidth = 1

    }
    
    func configure(with genre: String) {
        genreLabel.text = genre
    }
}
