//
//  MovieCoordinator.swift
//  MoviesApp
//
//  Created by claudia.apostol on 9/5/23.
//

import UIKit

class MovieCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BaseTableViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
}
