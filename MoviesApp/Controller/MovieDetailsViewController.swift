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
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var titleView: TitleView!
    @IBOutlet weak var containerView: UIView!
    
    var movieToDisplay: Movie?
    weak var delegate: MovieDetailsDelegate?
    var networkingManager = NetworkManager()
    var moviesManager = MoviesListManager.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        displayOrDownloadDetails()
        setNavigationBarButton()
    }
    
    private func showSpinner() {
        spinnerView.startAnimating()
        containerView.isHidden = true
    }
    
    private func stopSpinner() {
        spinnerView.stopAnimating()
        containerView.isHidden = false
    }
    
    private func setNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: movieToDisplay?.getFavoriteImage(), style: .plain, target: self, action: #selector(heartTapped))
    }
    
    private func configureCustomViews(with movie: Movie) {
        titleView.configure(with: movie)
        detailsView.configure(with: movie)
        similarMoviesView.configure(with: movie)
    }
    
    private func displayOrDownloadDetails() {
        guard let movie = movieToDisplay else {
            return
        }
        
        guard let _ = movie.details else {
            networkingManager.getMovieDetails(for: movie.id) { result in
                switch result {
                case .success(let details):
                    let newMovie = self.moviesManager.setDetails(for: movie, details: details)
                    self.networkingManager.displayBackDropImage(for: newMovie)
                case .failure(let error):
                    print(error)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.stopSpinner()
                self.configureCustomViews(with: self.moviesManager.getMovieById(id: movie.id))
            }
           
            return
        }
        self.stopSpinner()
        self.configureCustomViews(with: movie)
    }
    
    @objc func heartTapped() {
        movieToDisplay?.isFavourite.toggle()
        delegate?.didChangeFavorite(movie: movieToDisplay!)
        setNavigationBarButton()
    }
}
