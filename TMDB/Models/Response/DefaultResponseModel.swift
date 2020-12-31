//
//  DefaultResponseModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Foundation

struct DefaultResponseModel: Codable {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
