//
//  MainTabBarController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 9/7/23.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    let movieCoordinator  = MovieCoordinator.init(navigationController: UINavigationController())
    let favoritesCoordinator = FavoritesCoordinator.init(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCoordinator.start()
        favoritesCoordinator.start()
        viewControllers = [movieCoordinator.navigationController, favoritesCoordinator.navigationController]
        
        self.tabBar.tintColor = .label
    }
}
