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

class MovieDetailsViewController: UIViewController, Storyboarded {
    @objc func detailsLoaded(notification: Notification) {
        guard let movie = notification.object as? Movie else { return }
        self.stopSpinner()
        self.movieToDisplay = movie
    }
    
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
    var networkingManager = MoviesAPIService()
    var moviesManager = MoviesDataClient.shared

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
        NotificationCenter.default.addObserver(self, selector:#selector(detailsLoaded(notification:)), name: .DetailsLoaded, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let title = self.title, let movie = moviesManager.getMovieByTitle(with: title) else {
            return
        }
        configureCustomViews(with: movie)
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
            networkingManager.downloadDetails(for: movieToDisplay.id)
        } else {
            self.stopSpinner()
            self.configureCustomViews(with: movieToDisplay)
        }
    }
    
    @objc func heartTapped() {
        // movieToDisplay.isFavourite.toggle()
        delegate?.didChangeFavorite(movie: movieToDisplay)
        setNavigationBarButtons()
    }
}

extension MovieDetailsViewController: SimilarMoviesDelegate {
    func cellDidSelectMovie(movie: Movie) {
        delegate?.didSelectSimilarMovie(movie: movie)
    }
}
