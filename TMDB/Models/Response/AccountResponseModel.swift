//
//  AccountResponseModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Foundation

// MARK: - AccountResponseModel
struct AccountResponseModel: Codable {
    let avatar: Avatar?
    let id: Int?
    let iso639_1, iso3166_1, name: String?
    let includeAdult: Bool?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar?
    let tmdb: Tmdb?
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String?
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
