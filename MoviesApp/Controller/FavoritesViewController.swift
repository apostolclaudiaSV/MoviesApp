//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    override var filterCriteria: FilterCriteria { .favourites }
    override var sortCriteria: SortCriteria { .none }
    
}
