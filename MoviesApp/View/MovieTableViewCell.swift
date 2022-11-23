//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/11/22.
//

import UIKit
enum Icon {
    case heart
    case heartFill
    case noImage
    case arrow
    
    var image: UIImage {
        switch self {
        case .heart: return UIImage(systemName: "heart")!
        case .heartFill: return UIImage(systemName: "heart.fill")!
        case .noImage: return UIImage(named: "No-Photo-Available")!
        case .arrow: return UIImage(systemName: "chevron.right")!
        }
    }
    
    var data: Data {
        switch self {
        case .noImage: return image.pngData()!
        default: return Data()
        }
    }
}
class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var poster: UIImageView!
    
    var hideFavoriteButton = false
    weak var delegate: MovieCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.backgroundColor = UIColor.clear.withAlphaComponent(0.2)
        self.accessoryView = setupCellAccesory()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        favoriteButton.isHidden = hideFavoriteButton
    }
    
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
        rating.text = String(movie.rating)
        releaseYear.text = movie.releaseYear
        favoriteButton.setImage(self.getFavoriteImage(for: movie), for: .normal)
        favoriteButton.isHidden = hideFavoriteButton
        poster.image = movie.posterImage
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        delegate?.cellDidToggleFavorite(cell: self)
    }
    
    private func getFavoriteImageColor(for movie: Movie) -> UIColor {
        return movie.isFavourite ? UIColor.red : UIColor.white
    }
    
    private func getFavoriteImage(for movie: Movie) -> UIImage {
        let favoriteImage = movie.isFavourite ? Icon.heartFill.image : Icon.heart.image
        return favoriteImage.withTintColor(getFavoriteImageColor(for: movie), renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(scale: .medium))
    }
    
    private func setupCellAccesory() -> UIImageView {
        let image = Icon.arrow.image
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image.size.width), height:(image.size.height)))
        accessory.image = image
        accessory.tintColor = UIColor.label
        return accessory
    }
}
