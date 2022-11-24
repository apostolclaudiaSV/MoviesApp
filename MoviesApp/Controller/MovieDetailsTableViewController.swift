//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/23/22.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {

    var movieToDisplay: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "MovieTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTitleTableViewCell")
        tableView.register(UINib.init(nibName: "BackdropTableViewCell", bundle: nil), forCellReuseIdentifier: "BackdropTableViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icon.heart.image, style: .plain, target: self, action: #selector(heartTapped))
        navigationItem.rightBarButtonItem?.tintColor = .red
        //view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    @objc func heartTapped() {
        
    }
}

extension MovieDetailsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTitleTableViewCell", for: indexPath) as! MovieTitleTableViewCell
            cell.configure(with: movieToDisplay!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BackdropTableViewCell", for: indexPath) as! BackdropTableViewCell
            cell.configure(with: movieToDisplay!)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension MovieDetailsTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        case 1:
            return 150
        default:
            return 0
        }
    }
}
