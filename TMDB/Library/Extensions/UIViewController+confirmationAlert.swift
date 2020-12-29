//
//  UIViewController+confirmationAlert.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UIViewController {
    func confirmationAlert(
        title: String,
        message: String,
        actionTitle: String,
        completion: @escaping (UIAlertAction) -> Void) {
        
        let confirmationAlert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: actionTitle,
            style: .destructive,
            handler: completion
        )
        
        let cancel = UIAlertAction(
            title: L10n.cancelAction,
            style: .cancel,
            handler: nil
        )
        confirmationAlert.addAction(action)
        confirmationAlert.addAction(cancel)
        confirmationAlert.view.tintColor = .black
        present(confirmationAlert, animated: true)
    }
}
