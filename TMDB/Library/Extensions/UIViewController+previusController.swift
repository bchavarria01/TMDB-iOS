//
//  UIViewController+previusController.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UIViewController {
    var previousViewController: UIViewController? {
        if let controllersOnStack = navigationController?.viewControllers {
            let controllersCount = controllersOnStack.count
            if controllersOnStack.last === self, controllersCount > 1 {
                return controllersOnStack[controllersCount - 2]
                
            } else if controllersCount > 0 {
                return controllersOnStack[controllersCount - 1]
            }
        }
        return nil
    }
}
