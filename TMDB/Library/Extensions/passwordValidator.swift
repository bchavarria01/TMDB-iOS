//
//  passwordValidator.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Foundation

extension String {
    func validPasswordLength() -> Bool {
        let passwordreg =  ("^.{8,20}$")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: self)
    }
    
    func validPasswordUppercase() -> Bool {
        let passwordreg =  (".*[A-Z]+.*")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: self)
    }
    
    func validPasswordLowerCase() -> Bool {
        let passwordreg =  (".*[a-z]+.*")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: self)
    }
    
    func validPasswordSpecial() -> Bool {
        let passwordreg =  (".*[#?!@$%^&*-]+.*")
        let passwordNumbersReg = (".*[0-9]+.*")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        let passwordNumbertesting = NSPredicate(format: "SELF MATCHES %@", passwordNumbersReg)
        
        if passwordtesting.evaluate(with: self) || passwordNumbertesting.evaluate(with: self) {
            return true
        }
        return false
    }
}
