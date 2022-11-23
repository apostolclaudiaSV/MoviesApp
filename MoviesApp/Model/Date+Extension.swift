//
//  Date+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/23/22.
//

import Foundation

extension Date {
    func getYearFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: self)
    }
}
