//
//  MovieTitleTableViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/23/22.
//

import UIKit

class MovieTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        releaseYearLabel.text = movie.releaseYear
        durationLabel.text = movie.details?.convertDurationTime()
        ratingLabel.attributedText = configureRatingLabel(for: String(movie.rating))
    }
    
    private func configureRatingLabel(for rating: String) -> NSMutableAttributedString {
        let maximumRating = Text.maximumRating.text
        let maximumRatingString = NSMutableAttributedString(string: maximumRating, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        let ratingString = NSMutableAttributedString(string: rating, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        ratingString.append(maximumRatingString)
        return ratingString
    }
}
