//
//  SimilarMovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 12/9/22.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with movie: Movie) {
        posterImage.image = movie.posterImage
        ratingLabel.text = "\(movie.rating)"
        titleLabel.text = movie.title
    }
}
