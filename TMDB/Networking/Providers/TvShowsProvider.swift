//
//  TvShowsProvider.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Moya

enum TvShowsProvider {
    case getPopular(page: Int)
    case getTopRated(page: Int)
    case getOnTv(page: Int)
    case getAiring(page: Int)
    case getDetail(tvId: Int)
    case getCredits(tvId: Int)
    case getSeasonInfo(tvId: Int, seasonId: Int)
}

// MARK: - TargetType

extension TvShowsProvider: TargetType {
    var baseURL: URL {
        switch self {
        case let .getPopular(page):
            return URL(string: "\(K.baseURL)/tv/popular?page=\(page)")!
            
        case let .getTopRated(page):
            return URL(string: "\(K.baseURL)/tv/top_rated?page=\(page)")!
            
        case let .getOnTv(page):
            return URL(string: "\(K.baseURL)/tv/on_the_air?page=\(page)")!
            
        case let .getAiring(page):
            return URL(string: "\(K.baseURL)/tv/airing_today?page=\(page)")!
            
        case let .getDetail(tvId):
            return URL(string: "\(K.baseURL)/tv/\(tvId)")!
            
        case let .getCredits(tvId):
            return URL(string: "\(K.baseURL)/tv/\(tvId)/credits")!
        
        case let .getSeasonInfo(tvId, seasonId):
            return URL(string: "\(K.baseURL)/tv/\(tvId)/season/\(seasonId)")!
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
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return K.MoyaDefaults.defaultHeaders
        }
    }
}
