//
//  NSMutableAttributedString+helpers.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension NSMutableAttributedString {    
    static func attributedString(
        _ text: String,
        font: UIFont,
        color: UIColor
    ) -> NSMutableAttributedString {
        
        let attributesForName: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.font: font
        ]
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: attributesForName
        )
        return attributedString
    }
}
