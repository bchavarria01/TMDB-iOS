//
//  UIViewController+showAlert.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async { [unowned self] in
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: handler
            ))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

