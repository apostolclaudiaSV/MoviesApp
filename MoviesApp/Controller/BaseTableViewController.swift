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
    func datasourceChanged() {
    }
    
    var filteredMovies: [Movie] = []
    var sortCriteria: SortCriteria { .popularityDesc }
    var filterCriteria: FilterCriteria { .none }
    var shouldHideFavoriteButton: Bool { false }
    var moviesManager = MoviesListManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        self.title = "All Movies"    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMovies()
        tableView.reloadData()
    }
    
    func reloadMovies() {
        filteredMovies = moviesManager.sortedAndFiltered(by: sortCriteria, filterCriteria: filterCriteria)
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
        moviesManager.modifyFavorite(index: moviesManager.getIndexOfSortedMovie(filteredMovies[indexPath.row]))
        reloadMovies()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
