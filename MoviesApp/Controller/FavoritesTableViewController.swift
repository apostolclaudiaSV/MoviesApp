//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import UIKit
import CoreData

class FavoritesTableViewController: BaseTableViewController {
    
    override var filterCriteria: FilterCriteria { .favourites }
    //override var sortCriteria: SortCriteria { .none }
    override var shouldHideFavoriteButton: Bool { true }
    override var screenTitle: String { Text.favoritesMovies.text }
    var filteredMoviesObject: [NSManagedObject] = []
    
    override func reloadFilteredMovies() {
        if let movieObject = moviesManager.getFavoriteMovies() {
            filteredMovies = []
            movieObject.forEach { movieObject in
                filteredMovies.append(movieObject.convertToMovie())
            }
        }
    }
}

extension FavoritesTableViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movie = filteredMovies[indexPath.row]
        let action = UIContextualAction(style: .normal,
                                        title: "Remove") { [weak self] (action, view, completionHandler) in
            self?.didChangeFavorite(movie: movie)
            tableView.reloadData()
            completionHandler(true)
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension NSManagedObject {
    func convertToMovie() -> Movie {
        return Movie.init(id: self.value(forKey: "id") as! Int, title: self.value(forKey: "title") as! String, rating: self.value(forKey: "rating") as! Double, releaseDate: self.value(forKey: "releaseDate") as! Date, isFavourite: true, overview: self.value(forKey: "overview") as! String, poster: self.value(forKey: "poster") as! String, details: nil, popularity: self.value(forKey: "popularity") as! Double, posterImage: nil)
    }
}
