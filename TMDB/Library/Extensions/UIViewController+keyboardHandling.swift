//
//  UIViewController+keyboardHandling.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UIViewController {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardGesture() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    func subscribeForKeyboardChange(_ target: UIViewController, selector: Selector ) {
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }        
}
