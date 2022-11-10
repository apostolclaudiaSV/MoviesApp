//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import UIKit

class FavoritesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        filterCriteria = .favourites
        sortCriteria = .none
    }

}
