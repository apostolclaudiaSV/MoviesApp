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

class BaseTableViewController: UITableViewController {
    @objc func datasourceChanged(notification: Notification) {
        reloadFilteredMovies()
        tableView.reloadData()
    }
    
    @objc func imageLoaded(notification: Notification) {
        guard let movie = notification.object as? Movie else {
            return
        }
        self.reloadOneMovie(movie: movie)
    }
    
    var filteredMovies: [Movie] = []
    var sortCriteria: SortCriteria { .popularityDesc }
    var filterCriteria: FilterCriteria { .none }
    var shouldHideFavoriteButton: Bool { false }
    var moviesManager = MoviesListManager.shared
    var networkingManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        self.title = "All Movies"
        
        NotificationCenter.default.addObserver(self, selector:#selector(datasourceChanged(notification:)), name: .DatasourceChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(imageLoaded(notification:)), name: .ImageLoaded, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFilteredMovies()
        tableView.reloadData()
    }
    
    func reloadFilteredMovies() {
        filteredMovies = moviesManager.sortedAndFiltered(by: sortCriteria, filterCriteria: filterCriteria)
    }
    
    func reloadOneMovie(movie: Movie) {
        let indexPath = IndexPath(row: moviesManager.getIndexOfSortedMovie(movie), section: 0)
        reloadFilteredMovies()
        tableView.reloadRows(at: [indexPath], with: .none)
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
}

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
}
