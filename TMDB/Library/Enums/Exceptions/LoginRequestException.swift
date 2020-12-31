//
//  LoginRequestException.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Foundation

enum LoginRequestException {
    case username
    case password
}

// MARK: - ValidationExption

extension LoginRequestException: ValidationException {
    var description: String {
        switch self {
        case .username: return "Invalid username"
        case .password: return "Invalid password"
        }
    }
}
