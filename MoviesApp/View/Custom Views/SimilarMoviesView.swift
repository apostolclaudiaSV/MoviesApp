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
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("SimilarMoviesView", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }

    func configure(with movie: Movie) {
        
    }
}
