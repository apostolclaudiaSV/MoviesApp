//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/23/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var similarMoviesView: SimilarMoviesView!
    @IBOutlet weak var detailsView: DetailsAndGenreView!
    @IBOutlet weak var titleView: TitleView!
    
    var movieToDisplay: Movie?
    weak var delegate: MovieDetailsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setImage()
    }
    
    private func setImage() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: movieToDisplay?.getFavoriteImage(), style: .plain, target: self, action: #selector(heartTapped))
    }
    
    private func configureViews() {
        if let movie = movieToDisplay {
            titleView.configure(with: movie)
            detailsView.configure(with: movie)
            similarMoviesView.configure(with: movie)
        }
    }
    
    @objc func heartTapped() {
        movieToDisplay?.isFavourite.toggle()
        delegate?.didChangeFavorite(movie: movieToDisplay!)
        setImage()
    }
}
