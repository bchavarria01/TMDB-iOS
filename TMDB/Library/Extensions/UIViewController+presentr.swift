//
//  UIViewController+presentr.swift
//  TMDB
//
//  Created by Byron Chavarría on 3/1/21.
//

import UIKit
import Presentr

extension UIViewController {
    func presentModal(
        _ viewController: UIViewController,
        width: ModalSize,
        height: ModalSize,
        backgroundOpacity: Float,
        completition: (() -> Void)? = nil) {
        
        let presenter = Presentr.defaultPresenter(width: width, height: height)
        presenter.backgroundColor = .black
        presenter.backgroundOpacity = backgroundOpacity
        //TODO: Review this dismiss
        presenter.backgroundTap = .noAction
        presenter.roundCorners = true
        presenter.cornerRadius = 8
        
        self.customPresentViewController(
            presenter,
            viewController: viewController,
            animated: true,
            completion: completition
        )
    }
}
