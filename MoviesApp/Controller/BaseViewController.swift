//
//  ViewController.swift
//  MoviesApp
//
//  Created by claudia.apostol on 10/31/22.
//

import UIKit

class BaseViewController: UIViewController {

    let movieList = MoviesListProvider()
    var filteredMovies: [Movie] = []
    var sortCriteria: SortCriteria = .popularityDesc
    var filterCriteria: FilterCriteria = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filteredMovies = movieList.sortAndFilter(sortCriteria: sortCriteria, filterCriteria: filterCriteria)
    }

}

extension BaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitleCell")
        let movieToDispaly = filteredMovies[indexPath.row]
        
        cell.textLabel?.text = movieToDispaly.title
        cell.detailTextLabel?.text = movieToDispaly.overview
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}

extension BaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
