//
//  ViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 10/31/22.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
    func cellDidToggleFavorite(cell: MovieTableViewCell)
}

protocol MovieDetailsDelegate: AnyObject {
    func didChangeFavorite(movie: Movie)
    func didSelectSimilarMovie(movie: Movie)
}

class BaseTableViewController: UITableViewController {
    @objc func datasourceChanged(notification: Notification) {
        reloadFilteredMovies()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func imageLoaded(notification: Notification) {
        guard let movie = notification.object as? Movie else {
            return
        }
        self.reloadOneMovie(movie: movie)
    }
    
    var filteredMovies: [Movie] = []
    var sortCriteria: SortCriteria = .popularityDesc
    var filterCriteria: FilterCriteria { .none }
    var shouldHideFavoriteButton: Bool { false }
    var moviesManager = MoviesDataClient.shared
    var networkingManager = MoviesAPIService()
    let fileManager = MoviesFileService()
    var screenTitle: String { Text.allMovies.text }
    var currentPage = 1
    var isLoadingList = false
    @IBOutlet weak var footerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.tableFooterView = footerView
        self.title = screenTitle
        getMovieList()

        NotificationCenter.default.addObserver(self, selector:#selector(datasourceChanged(notification:)), name: .DatasourceChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(imageLoaded(notification:)), name: .ImageLoaded, object: nil)
                
        let navItems = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.circle"), menu: createContextMenu())
        self.navigationItem.rightBarButtonItem = navItems
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFilteredMovies()
        tableView.reloadData()
        footerView?.startAnimating()
    }
    
    private func createContextMenu() -> UIMenu {
        var children: [UIAction] = []
        for sortTitle in SortCriteria.allCases {
            if let titlee = sortTitle.criteriaTitle {
                let popularity = UIAction(title: titlee, state: self.sortCriteria == sortTitle ? .on : .off) { (action) in
                    self.sortCriteria = sortTitle
                    self.getMovieList(with: self.sortCriteria)
                    self.navigationItem.rightBarButtonItem?.menu = self.createContextMenu()
                }
                children.append(popularity)
            }
        }
        return UIMenu(title: "Sort by", options: .displayInline, children: children)
    }
    
    func reloadFilteredMovies() {
        filteredMovies = moviesManager.sortedAndFiltered(by: sortCriteria, filterCriteria: filterCriteria)
    }
    
    func reloadOneMovie(movie: Movie) {
        guard let index = moviesManager.getIndexOfSortedMovie(movie) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        guard let movieIndex = filteredMovies.firstIndex(where: { $0.id == movie.id }) else { return }
        filteredMovies[movieIndex] = movie
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func showDetailsScreen(for movie: Movie) {
        if let detailsVC = storyboard?.instantiateViewController(identifier: "MovieDetailsTableViewController", creator: { coder -> MovieDetailsViewController? in
            MovieDetailsViewController(coder: coder, movie: movie)
        }) {
            detailsVC.delegate = self
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    private func getMovieList(with sortCriteria: SortCriteria = .none) {
        isLoadingList = true
        footerView?.startAnimating()
        networkingManager.fetchMovies(pageNumber: currentPage) { [weak self] result in
            self?.isLoadingList = false
            //self?.footerView.stopAnimating()
            switch result {
            case .success(let movies):
                self?.moviesManager.updateAllMovies(with: movies)
            case .failure(let error):
                self?.fileManager.fetchMovies()
                print(error.description ?? "")
            }
        }
    }
    
    private func loadMoreItems(){
        currentPage += 1
        getMovieList(with: sortCriteria)
    }
}

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movieToDispaly = filteredMovies[indexPath.row]
        cell.delegate = self
        cell.hideFavoriteButton = shouldHideFavoriteButton
        cell.configure(with: movieToDispaly)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if filteredMovies.count >= 2 && indexPath.row == filteredMovies.count - 2 && !isLoadingList && !filterCriteria.isFavorites {
            self.loadMoreItems()
        }
    }
}

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailsScreen(for: self.filteredMovies[indexPath.row])
    }
}

extension BaseTableViewController: MovieCellDelegate {
    func cellDidToggleFavorite(cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        moviesManager.modifyFavorite(for: filteredMovies[indexPath.row])
        reloadFilteredMovies()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension Notification.Name {
    static let DatasourceChanged = Notification.Name("datasourceChanged")
    static let ImageLoaded = Notification.Name("imageLoaded")
    static let DetailsLoaded = Notification.Name("detailsLoaded")
}

extension BaseTableViewController: MovieDetailsDelegate {
    func didSelectSimilarMovie(movie: Movie) {
        showDetailsScreen(for: movie)
    }
    
    func didChangeFavorite(movie: Movie) {
        moviesManager.modifyFavorite(for: movie)
        reloadFilteredMovies()
    }
    
}
