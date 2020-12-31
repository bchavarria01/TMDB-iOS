//
//  LoginRequestModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Foundation

struct LoginRequestModel: LocalizableErrorBased {
    let username: String
    let password: String
}

// MARK: - ValidatableModel

extension LoginRequestModel: ValidatebleModel {
    func throwExeptionIfcontains() -> ValidationException? {
        let usernameHasValidLenght = SourceValidations.hasValidLenght(
            username,
            maxLenght: K.Validations.maxUsernameLenght,
            minLenght: K.Validations.minUsernameLenght
        )
        
        guard usernameHasValidLenght
            else { return LoginRequestException.username }
        
        let passwordHasValidLenght = SourceValidations.hasValidLenght(
            password,
            maxLenght: K.Validations.maxPasswordLenght,
            minLenght: K.Validations.minPasswordLenght
        )
        
        guard passwordHasValidLenght
            else { return LoginRequestException.password }
        
        return nil
    }
}
