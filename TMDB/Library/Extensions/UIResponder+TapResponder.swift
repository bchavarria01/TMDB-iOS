//
//  UIResponder+TapResponder.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UIResponder {
    @objc func didSelectTvShow() {
        next?.didSelectTvShow()
    }
}
