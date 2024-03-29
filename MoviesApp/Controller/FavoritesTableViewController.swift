//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import UIKit

class FavoritesTableViewController: BaseTableViewController {
    
    override var filterCriteria: FilterCriteria { .favourites }
    //override var sortCriteria: SortCriteria { .none }
    override var shouldHideFavoriteButton: Bool { true }
    override var screenTitle: String { Text.favoritesMovies.text }
    
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
