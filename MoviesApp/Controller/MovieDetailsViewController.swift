//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/23/22.
//

import UIKit

protocol SimilarMoviesDelegate: AnyObject {
    func cellDidSelectMovie(movie: Movie)
}

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var similarMoviesView: SimilarMoviesView!
    @IBOutlet weak var detailsView: DetailsAndGenreView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var titleView: TitleView!
    @IBOutlet weak var containerView: UIView!
    
    var movieToDisplay: Movie {
        didSet {
           configureCustomViews(with: movieToDisplay)
        }
    }
    
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
        setNavigationBarButtons()
    }
    
    private func showSpinner() {
        spinnerView.startAnimating()
        containerView.isHidden = true
    }
    
    private func stopSpinner() {
        spinnerView.stopAnimating()
        containerView.isHidden = false
    }
    
    private func setNavigationBarButtons() {
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: movieToDisplay.getFavoriteImage(), style: .plain, target: self, action: #selector(heartTapped))
    }
    
    private func configureCustomViews(with movie: Movie) {
        titleView.configure(with: movie)
        detailsView.configure(with: movie)
        similarMoviesView.configure(with: movie)
        
        similarMoviesView.delegate = self
    }
    
    private func displayOrDownloadDetails() {
        if movieToDisplay.details == nil {
            networkingManager.getMovieDetails(for: movieToDisplay.id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let details):
                    let id = self.movieToDisplay.id
                    self.moviesManager.setDetails(for: id, details: details)
                    self.networkingManager.getBackDropImage(for: details.backdropPath) { [weak self] image in
                        guard let self = self else { return }
                        self.moviesManager.setBackDrop(for: id, image: image)
                        self.networkingManager.getSimilarMovies(for: id) { [weak self] result in
                            guard let self = self else { return }
                            switch result {
                            case .success(let movies):
                                self.moviesManager.setSimilarMovies(for: id, movies: movies)
                                self.stopSpinner()
                                guard let movie = self.moviesManager.getMovieById(id: id) else { return }
                                self.movieToDisplay = movie
                            case .failure(let error):
                                print(error)
                            }
                        }
                       
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.stopSpinner()
            self.configureCustomViews(with: movieToDisplay)
        }
    }
    
    @objc func heartTapped() {
        movieToDisplay.isFavourite.toggle()
        delegate?.didChangeFavorite(movie: movieToDisplay)
        setNavigationBarButtons()
    }
}

extension MovieDetailsViewController: SimilarMoviesDelegate {
    func cellDidSelectMovie(movie: Movie) {
        delegate?.didSelectSimilarMovie(movie: movie)
    }
}
