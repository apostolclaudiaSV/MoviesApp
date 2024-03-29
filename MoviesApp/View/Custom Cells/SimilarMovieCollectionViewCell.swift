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
    
    func configure(with movie: Movie) {
        movieToDisplay = movie
        ratingLabel.text = "\(movie.rating)"
        titleLabel.text = movie.title
        if let img = MoviesDataClient.shared.getMovieById(id: movie.id)?.posterImage {
            posterImage.image = img
        } else {
            posterImage.image = UIImage(data: Icon.noImage.data)
            NotificationCenter.default.addObserver(self, selector:#selector(similarImageLoaded(notification:)), name: .ImageLoaded, object: nil)
        }
    }
    
    @objc func similarImageLoaded(notification: Notification) {
        guard let movie = notification.object as? Movie, movie.id == movieToDisplay?.id else {
            return
        }
        posterImage.image = movie.posterImage
    }
}
