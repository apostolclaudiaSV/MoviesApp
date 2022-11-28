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
        let view = Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
}
