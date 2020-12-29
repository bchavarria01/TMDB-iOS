//
//  SourceValidations.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Foundation

enum SourceValidations {
    static func isValidEmail(_ source: String?) -> Bool {
        guard let source = source else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: source)
    }
    
    static func isValidPhone(_ source: String?) -> Bool {
        guard let source = source else { return false }
        
        let phoneRegEx = "\\A[0-9]{8}\\z"
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        
        return phonePredicate.evaluate(with: source)
    }
    
    static func isGratherThanZero(_ value: String?) -> Bool {
        guard let value = value,
            let numberValue = Double(value)
            else { return false }
        
        return numberValue > 0
    }
    
    static func onlyNumbers(_ source: String?) -> Bool {
        guard let source = source else { return false }
        
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: source))
    }
    
    static func hasEqualsLenght(_ source: String?, lenght: UInt) -> Bool {
        guard let source = source else { return false }
        
        return source.count == lenght
    }
    
    static func hasValidLenght(_ source: String?, maxLenght: UInt?, minLenght: UInt?) -> Bool {
        guard let source = source else { return false }
        
        if let maxLenght = maxLenght {
            if  source.count > maxLenght {
                return false
            }
        }
        
        if let minLenght = minLenght {
            if  source.count < minLenght {
                return false
            }
        }
        
        return true
    }
    
    static func isSameString(_ firstSource: String?, secondSource: String?) -> Bool {
        guard let firstSource = firstSource else { return false }
        guard let secondSource = secondSource else { return false }
        
        if firstSource == secondSource {
            return true
        }
        
        return false
    }
}
