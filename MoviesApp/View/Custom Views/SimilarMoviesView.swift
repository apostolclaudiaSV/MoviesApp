//
//  SimilarMoviesView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class SimilarMoviesView: BaseCustomView{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var similarMovies: [Movie] = []
    weak var delegate: SimilarMoviesDelegate?
    
    func configure(with movie: Movie) {
        similarMovies.append(contentsOf: [movie, movie, movie, movie, movie]) // test data, will be changed after implementing the networking call
        setupCollectionView()
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib.init(nibName: "SimilarMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMovieCollectionViewCell")
    }
}

extension SimilarMoviesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCollectionViewCell", for: indexPath) as! SimilarMovieCollectionViewCell
        cell.configure(with: similarMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellDidSelectMovie(movie: similarMovies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
}
