//
//  BaseCustomView.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/28/22.
//

import UIKit

class BaseCustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let containerView = Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)?.first as! UIView
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     containerView.topAnchor.constraint(equalTo: self.topAnchor),
                                     containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)Ω])
    }
    
}
