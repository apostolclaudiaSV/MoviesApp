//
//  BackdropTableViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class BackdropTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie) {
        backdropImage.image = movie.posterImage
    }
}
