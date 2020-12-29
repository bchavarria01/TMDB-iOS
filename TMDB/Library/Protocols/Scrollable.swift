//
//  Scrollable.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

@objc protocol Scrollable {
    var scrollView: UIScrollView { get }
}

extension Scrollable {
    func scrollViewBouncesValueShouldChange(_ scrollView: UIScrollView) {
        let distance = scrollView.contentOffset.y
        if distance < 0 {
            scrollView.contentOffset.y = 0
        }
        scrollView.bounces = distance > 0
    }
}
