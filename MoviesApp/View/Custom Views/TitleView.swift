//
//  TitleView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class TitleView: BaseCustomView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var duarationLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        duarationLabel.text = movie.details?.convertDurationTime()
        releaseYearLabel.text = movie.releaseYear
        backdropImage.image = movie.posterImage
        ratingLabel.attributedText = configureRatingLabel(for: String(movie.rating))
    }
    
    private func configureRatingLabel(for rating: String) -> NSMutableAttributedString {
        let maximumRating = Text.maximumRating.text
        let maximumRatingString = NSMutableAttributedString(string: maximumRating, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        let ratingString = NSMutableAttributedString(string: rating, attributes: [NSAttributedString.Key.foregroundColor: UIColor.label])
        ratingString.append(maximumRatingString)
        return ratingString
    }
    
}
