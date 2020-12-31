//
//  CastResponseModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

// MARK: - CastResponseModel
struct CastResponseModel: Codable {
    let cast, crew: [Cast]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let character: String?
    let creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
