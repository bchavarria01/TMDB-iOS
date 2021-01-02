//
//  TvShowsModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 1/1/21.
//

import Foundation

class TvShowsModel {
    var backdropPath: String?
    var firstAirDate: String?
    var genreIDS: [Int]?
    var id: Int?
    var name: String?
    var originCountry: [String]?
    var originalLanguage: String?
    var originalName, overview: String?
    var popularity: Double?
    var posterPath: String?
    var voteAverage: Double?
    var voteCount: Int?
    var imageData: Data?
    var type: Int?
    
    init() {
        
    }
}
