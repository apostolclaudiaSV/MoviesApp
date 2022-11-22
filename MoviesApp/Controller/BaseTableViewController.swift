//
//  ViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 10/31/22.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
    func cellDidToggleFavorite(cell: MovieTableViewCell)
    func cellDidDownloadImage(cell: MovieTableViewCell)
}

class BaseTableViewController: UITableViewController {
    @objc func datasourceChanged(notification: Notification) {
        DispatchQueue.main.async {
            self.reloadFilteredMovies()
//          self.tableView.reloadData()
        }
    }
    
    @objc func imageLoaded(notification: Notification) {
        DispatchQueue.main.async {
            self.reloadFilteredMovies()
        }
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
        
        NotificationCenter.default.addObserver(self, selector:#selector(datasourceChanged(notification:)), name: Notification.Name("DataSourceChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(imageLoaded(notification:)), name: Notification.Name("ImageLoaded"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFilteredMovies()
//        self.tableView.reloadData()
    }
    
    func reloadFilteredMovies() {
        filteredMovies = moviesManager.sortedAndFiltered(by: sortCriteria, filterCriteria: filterCriteria)
        self.tableView.reloadData()
    }
    
//    func reloadOneMovie(movie: Movie) {
//        let indexPath = IndexPath(row: moviesManager.getIndexOfSortedMovie(movie), section: 0)
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
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
    func cellDidDownloadImage(cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        moviesManager.updateMovie(with: filteredMovies[indexPath.row])
        reloadFilteredMovies()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func cellDidToggleFavorite(cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        moviesManager.modifyFavorite(for: filteredMovies[indexPath.row])
        reloadFilteredMovies()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
