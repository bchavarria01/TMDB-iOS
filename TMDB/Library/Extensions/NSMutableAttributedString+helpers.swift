//
//  NSMutableAttributedString+helpers.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension NSMutableAttributedString {
    @discardableResult
    func bold(_ text: String, size: CGFloat) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: .bold)
        ]
        
        let boldString = NSMutableAttributedString(
            string:text,
            attributes: attributes
        )
        
        append(boldString)
        return self
    }
    
    func setColorForText(_ text: String, withColor color: UIColor) {
        let range: NSRange = mutableString.range(
            of: text,
            options: .caseInsensitive
        )
        
        // Swift 4.2 and above
        addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: color,
            range: range
        )
        
        // Swift 4.1 and below
        addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: color,
            range: range
        )
    }
    
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
