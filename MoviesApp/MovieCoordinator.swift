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
    weak var delegate: MovieDetailsDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BaseTableViewController.instantiate()
        vc.tabBarItem = UITabBarItem(title: "All Movies", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
//        delegate = vc
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToDetails(for movie: Movie) {
        //let vc = MovieDetailsViewController.instantiate()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController", creator: { coder -> MovieDetailsViewController? in
            MovieDetailsViewController(coder: coder, movie: movie)
        })
        navigationController.pushViewController(vc, animated: true)
        
    }
}
