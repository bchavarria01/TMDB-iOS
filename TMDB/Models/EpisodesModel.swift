//
//  EpisodesModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import Foundation

struct EpisodesModel {
    let seasonName: String?
    let episodes: [CustomEpisode]?
}

struct CustomEpisode {
    var episodeName: String?
    var episodePath: String?
    var episodeImage: Data?
}
