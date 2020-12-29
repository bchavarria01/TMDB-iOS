//
//  ValidatableModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Foundation

protocol ValidatebleModel {
    func throwExeptionIfcontains() -> ValidationException?
}
