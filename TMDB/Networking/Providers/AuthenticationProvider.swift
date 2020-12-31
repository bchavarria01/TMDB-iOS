//
//  AuthenticationService.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Moya

enum AuthenticationProvider {
    case getToken
    case authenticateWithLogin(request: LoginRequestModel)
}

// MARK: - TargetType

extension AuthenticationProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .getToken:
            return K.ServicesPath.token
            
        case .authenticateWithLogin:
            return K.ServicesPath.validateWithLogin
        }
    }

    var path: String {
        switch self {
        default:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getToken:  return .get
        case .authenticateWithLogin: return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var parameters: [String: Any] = [:]
        var encoding: URLEncoding?

        switch self {
        case .getToken:
            encoding = URLEncoding.default
            return .requestPlain
                
        case let .authenticateWithLogin(request):
            encoding = URLEncoding.default
            parameters["username"] = request.username
            parameters["password"] = request.password
            parameters["request_token"] = DefaultPreferences.current.requestToken
        }
        
        return .requestParameters(
            parameters: parameters,
            encoding: encoding ?? URLEncoding.default
        )
    }

    var headers: [String : String]? {
        switch self {
        case .getToken, .authenticateWithLogin:
            return K.MoyaDefaults.defaultHeaders
        }
    }
}


