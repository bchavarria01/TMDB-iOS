//
//  TvShowsDetailModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//

import Foundation

final class TvShowsDetailModel {
    var backdropPath: String?
    var createdBy: String?
    var id: Int?
    var name: String?
    var numberOfEpisodes, numberOfSeasons: Int?
    var overview: String?
    var posterPath: String?
    var status, type: String?
    var voteAverage: Double?
    var detailImageData: Data?
    var lastSeasonImageData: Data?
    var lastSeasonImagePath: String?
    var lastSeasonName: String?
    var lastSeasonReleaseDate: String?
}
