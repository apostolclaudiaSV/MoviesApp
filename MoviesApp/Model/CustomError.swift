//
//  CustomErrors.swift
//  MoviesApp
//
//  Created by claudia.apostol on 11/18/22.
//

import Foundation

enum CustomError: Error {
    case decodingFailure
}
extension CustomError: LocalizedError {
    var description: String? {
        switch self {
        case .decodingFailure:
            return NSLocalizedString("There was an error decoding the response", comment: "")
        }
    }
}
