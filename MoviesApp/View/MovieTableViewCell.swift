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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var poster: UIImageView!
    
    var hideFavoriteButton = false
    weak var delegate: FavoriteMovieDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.backgroundColor = UIColor.clear.withAlphaComponent(0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        favoriteButton.isHidden = hideFavoriteButton
    }
    
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
        rating.text = String(movie.rating)
        releaseYear.text = movie.releaseYear
        poster.image = UIImage(named: "No-Photo-Available")
        favoriteButton.setImage(self.getFavoriteImage(for: movie), for: .normal)
        favoriteButton.isHidden = hideFavoriteButton
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        delegate?.setFavoriteFor(for: self)
    }
    
    private func getFavoriteImageColor(for movie: Movie) -> UIColor {
        return movie.isFavourite ? UIColor.red : UIColor.white
    }
    
    private func getFavoriteImage(for movie: Movie) -> UIImage {
        let favoriteImage = movie.isFavourite ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        return favoriteImage.withTintColor(getFavoriteImageColor(for: movie), renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(scale: .medium))
    }
}
