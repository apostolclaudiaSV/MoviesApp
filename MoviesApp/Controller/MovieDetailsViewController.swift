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
    
    var movieToDisplay: Movie
    weak var delegate: MovieDetailsDelegate?
    var networkingManager = NetworkManager()
    var moviesManager = MoviesListManager.shared

    init?(coder: NSCoder, movie: Movie) {
        movieToDisplay = movie
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieToDisplay.title
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: movieToDisplay.getFavoriteImage(), style: .plain, target: self, action: #selector(heartTapped))
    }
    
    private func configureCustomViews(with movie: Movie) {
        titleView.configure(with: movie)
        detailsView.configure(with: movie)
        similarMoviesView.configure(with: movie)
    }
    
    private func displayOrDownloadDetails() {
        if movieToDisplay.details == nil {
            networkingManager.getMovieDetails(for: movieToDisplay.id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let details):
                    let id = self.movieToDisplay.id
                    self.moviesManager.setDetails(for: id, details: details)
                    let movie = self.moviesManager.getMovieById(id: id)
                    self.networkingManager.getBackDropImage(for: movie.details?.backdropPath) { [weak self] image in
                        guard let self = self else { return }
                        self.moviesManager.setBackDrop(for: movie, image: image)
                        self.stopSpinner()
                        self.movieToDisplay = self.moviesManager.getMovieById(id: id)
                        self.configureCustomViews(with: self.movieToDisplay)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        self.stopSpinner()
        self.configureCustomViews(with: movieToDisplay)
    }
    
    @objc func heartTapped() {
        movieToDisplay.isFavourite.toggle()
        delegate?.didChangeFavorite(movie: movieToDisplay)
        setNavigationBarButton()
    }
}
