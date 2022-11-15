//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import UIKit

class FavoritesTableViewController: BaseTableViewController {
    
    override var filterCriteria: FilterCriteria { .favourites }
    override var sortCriteria: SortCriteria { .none }
    override var shouldHideFavoriteButton: Bool { true }
    
}
