//
//  ValidationException.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Foundation

protocol ValidationException: Error {
    var description: String { get }
}
