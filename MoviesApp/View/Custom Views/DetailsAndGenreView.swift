//
//  DetailsAndGenreView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class DetailsAndGenreView: BaseCustomView {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overviewTextField: UITextView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    var genres: [Genre] = []

    func configure(with movie: Movie) {
        if let img = movie.posterImage {
            posterImage.image = img
        } else {
            posterImage.image = UIImage(data: Icon.noImage.data)
        }
        overviewTextField.text = movie.overview
        setupCollectionView()
        genres = movie.details?.genres ?? []
        genreCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        genreCollectionView.register(UINib.init(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        genreCollectionView.collectionViewLayout = layout
    }
}

extension DetailsAndGenreView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        cell.configure(with: genres[indexPath.row].name)
        return cell
    }
}
