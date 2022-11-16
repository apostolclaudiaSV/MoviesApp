//
//  ViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 10/31/22.
//

import UIKit

protocol FavoriteMovieDelegate: AnyObject {
    func setFavoriteFor(for cell: MovieTableViewCell)
}

class BaseTableViewController: UITableViewController, FavoriteValueDelegate {
    func datasourceChanged() {
    }
    
    var filteredMovies: [Movie] = []
    var sortCriteria: SortCriteria { .popularityDesc }
    var filterCriteria: FilterCriteria { .none }
    var shouldHideFavoriteButton: Bool { false }
    var moviesSingleton = MovieListManager.shared.sharedMovies

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMovies = moviesSingleton.sortAndFilter(sortCriteria: sortCriteria, filterCriteria: filterCriteria)
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        self.title = "All Movies"
        moviesSingleton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filteredMovies = moviesSingleton.sortAndFilter(unsortedMovieList: moviesSingleton.moviess, sortCriteria: sortCriteria, filterCriteria: filterCriteria)
        tableView.reloadData()
    }
}

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.accessoryView = setupCellAccesory()
        
        let movieToDispaly = filteredMovies[indexPath.row]
        cell.delegate = self
        cell.hideFavoriteButton = shouldHideFavoriteButton
        cell.configure(with: movieToDispaly)
        
        return cell
    }
    
    private func setupCellAccesory() -> UIImageView {
        let image = Icon.arrow.image
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image.size.width), height:(image.size.height)))
        accessory.image = image
        accessory.tintColor = UIColor.label
        return accessory
    }
}

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension BaseTableViewController: FavoriteMovieDelegate {
    func setFavoriteFor(for cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        moviesSingleton.modifyFavorite(index: indexPath.row)
        filteredMovies = moviesSingleton.sortAndFilter(unsortedMovieList: moviesSingleton.moviess, sortCriteria: sortCriteria, filterCriteria: filterCriteria)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
