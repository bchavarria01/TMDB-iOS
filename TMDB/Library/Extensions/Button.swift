//
//  Button.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UIButton {

    func flash(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.05
        flash.fromValue = 1
        flash.toValue = 0.7
        flash.autoreverses = true
        flash.repeatCount = 1

        layer.add(flash, forKey: nil)
    }
}
