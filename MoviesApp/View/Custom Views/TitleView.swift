//
//  TitleView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class TitleView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var duarationLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let view = Bundle.main.loadNibNamed("TitleView", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        duarationLabel.text = movie.details?.convertDurationTime()
        releaseYearLabel.text = movie.releaseYear
        backdropImage.image = movie.posterImage
        ratingLabel.attributedText = configureRatingLabel(for: String(movie.rating))
    }
    
    private func configureRatingLabel(for rating: String) -> NSMutableAttributedString {
        let maximumRating = Text.maximumRating.text
        let maximumRatingString = NSMutableAttributedString(string: maximumRating, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        let ratingString = NSMutableAttributedString(string: rating, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        ratingString.append(maximumRatingString)
        return ratingString
    }
    
    class func instanceFromNib() -> TitleView {
            let view = UINib(nibName: "TitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleView
            return view
    }

}
