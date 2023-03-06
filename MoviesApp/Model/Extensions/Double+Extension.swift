//
//  Double+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 1/9/23.
//

import Foundation

extension Double {
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
