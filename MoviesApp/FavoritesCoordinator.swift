//
//  FavoritesCoordinator.swift
//  MoviesApp
//
//  Created by claudia.apostol on 9/7/23.
//

import UIKit

class FavoritesCoordinator: MovieCoordinator {
    
    override func start() {
        let vc = FavoritesTableViewController.instantiate()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        navigationController.pushViewController(vc, animated: false)
    }
}
