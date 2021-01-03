//
//  DetailViewControllerDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//

import Foundation

protocol DetailViewControllerDelegate: class {
    func detialViewControllerDidSelectViewAllSeasons(wit tvId: Int, and numberOfSeasons: Int)
}
