//
//  ViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 10/31/22.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    let movieList = MoviesListProvider()
    var filteredMovies: [Movie] = []
    var sortCriteria: SortCriteria { .popularityDesc }
    var filterCriteria: FilterCriteria { .none }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMovies = movieList.sortAndFilter(sortCriteria: sortCriteria, filterCriteria: filterCriteria)
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
}

extension BaseTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movieToDispaly = filteredMovies[indexPath.row]
        cell.configure(with: movieToDispaly.title, ratingGiven: movieToDispaly.rating, year: movieToDispaly.releaseYear)
//        cell.textLabel?.text = movieToDispaly.title
//        cell.detailTextLabel?.text = movieToDispaly.overview
//        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
