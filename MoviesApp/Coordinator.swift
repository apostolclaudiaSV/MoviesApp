//
//  Coordinator.swift
//  MoviesApp
//
//  Created by claudia.apostol on 9/5/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
