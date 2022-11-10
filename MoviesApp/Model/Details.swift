//
//  Details.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/10/22.
//

import Foundation

struct Details {
    let duration: Int
    let genres: [Genre]
    
    func convertDurationTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: TimeInterval(duration * 60)) ?? ""
    }
}
