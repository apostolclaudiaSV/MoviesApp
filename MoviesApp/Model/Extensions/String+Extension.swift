//
//  String+Extension.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
}
