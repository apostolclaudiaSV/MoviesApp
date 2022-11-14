//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/11/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with title: String, ratingGiven: Double, year: String, posterImage: UIImage = UIImage()) {
        movieTitle.text = title
        rating.text = String(ratingGiven)
        releaseYear.text = year
        poster.image = UIImage(named: "No-Photo-Available")
    }
    
}
