//
//  LocalizableErrorBased.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Foundation

protocol LocalizableErrorBased: ValidatebleModel {}

extension LocalizableErrorBased {
    func localizeError() -> ValidationException? {
        return self.throwExeptionIfcontains()
    }
}
