//
//  AccountStatesResponseModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Foundation

// MARK: - AccountStatesResponseModel
struct AccountStatesResponseModel: Codable {
    let id: Int
    let favorite, rated, watchlist: Bool
}

