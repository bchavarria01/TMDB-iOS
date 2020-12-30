//
//  Extensions.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit
import Presentr
import Moya

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}

extension UIView {
    func cornerRadius(with corners: CACornerMask, cornerRadii: CGFloat) {
        self.layer.cornerRadius = cornerRadii
        self.layer.maskedCorners = corners
    }
}

extension UIImageView {
    func roundImage() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

extension UIViewController {
    func handleNetworkError(with error: MoyaError?, completitionHandler: (() -> Void)?) {
        let response: Response? = error?.response
        let statusCode: HTTPStatusCode? = response?.status
        let responseType: HTTPStatusCode.ResponseType? = response?.responseType
        var errorMessage: String?
        switch responseType {
        case .success:
            if statusCode == .noContent {
                errorMessage = L10n.notValidData
            } else {
                errorMessage = L10n.errorHasOcurred
            }
        case .clientError:
            if statusCode == .unauthorized {
                errorMessage = L10n.sessionHasExpired
            } else {
                errorMessage = L10n.errorHasOcurred
            }
        case .serverError:
            errorMessage = L10n.errorHasOcurred
        default:
            print("No error in response")
        }
        
        let screenSize: CGRect = UIScreen.main.bounds
//        let controller = DefaultModalViewController()
//        controller.descriptionLabel.text = errorMessage
//        controller.completitionHandler = completitionHandler
//        controller.type = .error
//
//        self.presentModal(
//            controller,
//            width: .custom(size: Float(screenSize.width - 32)),
//            height: .custom(size: 210),
//            backgroundOpacity: 0.4
//        )
        
    }
}
