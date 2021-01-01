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

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 24)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}

extension UIViewController {
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleNetworkError(with error: MoyaError?, completitionHandler: (() -> Void)?) {
        let response: Response? = error?.response
        let statusCode: HTTPStatusCode? = response?.status
        let responseType: HTTPStatusCode.ResponseType? = response?.responseType
        var errorMessage: String?
        print(errorMessage ?? "")
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
        _ = screenSize
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
