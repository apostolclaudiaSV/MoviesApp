//
//  SimilarMoviesView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/24/22.
//

import UIKit

class SimilarMoviesView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initWithNibName("SimilarMoviesView")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initWithNibName("SimilarMoviesView")
    }

    func configure(with movie: Movie) {
        
    }
}
