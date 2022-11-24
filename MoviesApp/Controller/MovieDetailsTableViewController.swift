//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/23/22.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {

    var movieToDisplay: Movie?
    weak var delegate: MovieDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setImage()
    }
    
    private func setImage() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: movieToDisplay?.getFavoriteImage(), style: .plain, target: self, action: #selector(heartTapped))
    }
    
    private func setTableView() {
        tableView.register(UINib.init(nibName: "MovieTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTitleTableViewCell")
        tableView.register(UINib.init(nibName: "BackdropTableViewCell", bundle: nil), forCellReuseIdentifier: "BackdropTableViewCell")
        tableView.register(UINib.init(nibName: "MovieDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDescriptionTableViewCell")
        tableView.register(UINib.init(nibName: "SimilarMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SimilarMoviesTableViewCell")
    }
    
    @objc func heartTapped() {
        movieToDisplay?.isFavourite.toggle()
        delegate?.didChangeFavorite(movie: movieToDisplay!)
        setImage()
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
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescriptionTableViewCell", for: indexPath) as! MovieDescriptionTableViewCell
            cell.configure(with: movieToDisplay!)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMoviesTableViewCell", for: indexPath) as! SimilarMoviesTableViewCell
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
        case 2:
            return 250
        default:
            return 100
        }
    }
}
