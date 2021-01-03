//
//  TvCastModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//

import Foundation

// MARK: - CastResponseModel
struct TvCastModel {
    var cast: [CustomCast]?
}

// MARK: - Cast
struct CustomCast {
    var name: String?
    var imagePath: String?
    var imageData: Data?
}
