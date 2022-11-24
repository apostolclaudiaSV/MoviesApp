//
//  MovieDescriptionTableViewCell.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class MovieDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UICollectionView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        genresCollectionView.register(UINib.init(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        genresCollectionView.collectionViewLayout = layout
        genresCollectionView.contentSize = stackView.frame.size
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie) {
        posterImage.image = movie.posterImage
        descriptionTextField.text = movie.overview
    }
    
}

extension MovieDescriptionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        var text = ""
        switch indexPath.row {
        case 0:
            text = "Comedy"
        case 1:
            text = "Science Fiction"
        case 2:
            text = "Adventure"
        case 3:
            text = "Documentary"
        case 4:
            text = "Action"
        default:
            text = "tralalalala"
        }
        cell.configure(with: text)
        return cell
    }
    
}

//extension MovieDescriptionTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return UICollectionViewFlowLayout.automaticSize
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//}
