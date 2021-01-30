//
//  AccountProvider.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Moya

enum AccountProvider {
    case getAccountDetail(sessionId: String)
    case markAsFav(tvId: Int, flag: Bool, userId: String, sessionId: String)
    case getFavoritesTvShows(userId: String, sessionId: String)
}

// MARK: - TargetType

extension AccountProvider: TargetType {
    var baseURL: URL {
        switch self {
        case let .getAccountDetail(sessionId):
            return URL(string: "\(K.baseURL)/account?session_id=\(sessionId)")!
            
        case let .markAsFav(_, _, userId, sessionId):
            return URL(string: "\(K.baseURL)/account/\(userId)/favorite?session_id=\(sessionId)")!
           
        case let .getFavoritesTvShows(userId, sessionId):
            return URL(string: "\(K.baseURL)/account/\(userId)/favorite/tv?session_id=\(sessionId)")!
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
        case .getAccountDetail, .getFavoritesTvShows:  return .get
        case .markAsFav: return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var parameters: [String: Any] = [:]
        var encoding: URLEncoding?
        switch self {
        case .getAccountDetail, .getFavoritesTvShows:
            return .requestPlain
            
        case let .markAsFav(tvId, flag, _, _):
            encoding = URLEncoding.default
            parameters["media_type"] = "tv"
            parameters["media_id"] = tvId
            parameters["favorite"] = flag
        }
        
        return .requestParameters(
            parameters: parameters,
            encoding: encoding ?? URLEncoding.default
        )
    }

    var headers: [String : String]? {
        switch self {
        default:
            return K.MoyaDefaults.defaultHeaders
        }
    }
}



