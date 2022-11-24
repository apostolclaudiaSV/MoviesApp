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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        releaseYearLabel.text = movie.releaseYear
        durationLabel.text = movie.details?.convertDurationTime()
        ratingLabel.text = "\(movie.rating)" + "/10"
    }
}
