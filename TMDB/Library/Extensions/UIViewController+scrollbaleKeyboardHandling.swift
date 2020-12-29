//
//  UIViewController+scrollbaleKeyboardHandling.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension Scrollable where Self: UIViewController & Scrollable {
    func handleScrollableInset(with notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.contentInset.bottom = frame.height
        }
    }
}
