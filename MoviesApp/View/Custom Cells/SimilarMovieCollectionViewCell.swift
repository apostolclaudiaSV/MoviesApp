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
    var movieToDisplay: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector:#selector(similarImageLoaded(notification:)), name: .SimiarImageLoaded, object: nil)
    }

    func configure(with movie: Movie) {
        movieToDisplay = movie
        //posterImage.image = movie.posterImage
        ratingLabel.text = "\(movie.rating)"
        titleLabel.text = movie.title
//        NetworkManager().getPosterImage(for: movie) { image in
//            self.posterImage.image = image
//        }

    }
    
    @objc func similarImageLoaded(notification: Notification) {
        guard let movie = notification.object as? Movie, movie.id == movieToDisplay?.id else {
            return
        }
        NetworkManager().getPosterImage(for: movie) { image in
            self.posterImage.image = image
        }
    }
}
