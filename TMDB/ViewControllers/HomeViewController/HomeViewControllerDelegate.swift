//
//  HomeViewControllerDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 2/1/21.
//

import Foundation

protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidSelectMenu()
    func homeViewControllerDidSelectTvShow(with tvId: Int)
}
