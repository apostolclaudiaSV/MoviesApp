//
//  SimilarMoviesView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class SimilarMoviesView: BaseCustomView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var moviee: Movie?
    func configure(with movie: Movie) {
        moviee = movie
        setupCollectionView()
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib.init(nibName: "SimilarMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMovieCollectionViewCell")
        
    }
}

extension SimilarMoviesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviee?.details?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCollectionViewCell", for: indexPath) as! SimilarMovieCollectionViewCell
        
        cell.configure(with: moviee!.posterImage!, rating: String(moviee!.rating), title: moviee!.title)
        return cell
    }
    
    
}
